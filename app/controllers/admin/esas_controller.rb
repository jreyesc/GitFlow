#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class Admin::EsasController < AdminController
  before_action :set_esa, only: [:show, :edit, :update, :destroy]
  before_action :get_esa_types, only: [:index, :show, :create ,:new , :edit, :update, :destroy]
  
  def index
    @esas = Esa.order('row_order ASC').all
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def update_row_order
    @esa = Esa.find(esa_params[:id])
    posIni = @esa.row_order.to_i
    posFin = esa_params[:row_order_position].to_i
    if (posIni > posFin)
      Esa.where("row_order >= ? and row_order < ?", posFin, posIni).update_all("row_order = row_order + 1")
    else
      Esa.where("row_order > ? and row_order <= ?", posIni, posFin).update_all("row_order = row_order - 1")
    end
    @esa.row_order = posFin
    @esa.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def show
    @int_page_type = 1
  end

  def new
    @esa = Esa.new
    @esa.assign_attributes(esa_params) if params[:esa]
    @int_page_type = 0
  end

  def create
    esa = Esa.new(esa_params)
    esa.row_order = esa.new_order
    begin
      if esa.save
        flash[:notice] = t('messages.successfully_created')
        redirect_to action: "index"
      else
        flash[:alert] = get_errors(esa)
        redirect_to action: "new", esa: esa.attributes
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "new", esa: esa.attributes
    end
  end

  def edit
    @int_page_type = 2
  end

  def update
    begin
      if @esa.update_attributes(esa_params)
        flash[:notice] = t('messages.successfully_updated')
        if esa_params[:areas_message].nil?
          redirect_to action: "show", id: params[:id]
        else
          redirect_to admin_esa_areas_path(@esa)
        end
      else
        flash[:alert] = get_errors(@esa)
        redirect_to action: "edit", id: params[:id]
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "edit", id: params[:id]
    end
  end

  def destroy
    begin
      if @esa.delete
        flash[:notice] = t('messages.successfully_deleted')
      else
        flash[:alert] = t('messages.error_ocurred')
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
    end
    redirect_to action: "index"
  end

  private
    def set_esa
      @esa = Esa.find(params[:id])
    end

    def get_esa_types
      @esa_types = EsaType.all
    end 

    def esa_params
      params.require(:esa).permit(:id, :esa_type_id, :title, :message, :first_section_msj, :second_section_msj,:main_image, :first_section_img, :second_section_img, :flag_show, :esa_type, :congratulations_message, :petition_link, :row_order_position, :areas_message)
    end
end
