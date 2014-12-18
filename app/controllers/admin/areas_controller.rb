class Admin::AreasController < AdminController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :set_esa, only: [:show, :edit, :update, :destroy]
  before_action :get_esas, only: [:index, :show, :create ,:new , :edit, :update, :destroy]

  def index
    unless params[:esa_id].nil?
      @esa = Esa.find(params[:esa_id])
    end
    search = Area.search do
      with(:esa_id, params[:esa_id]) unless params[:esa_id].blank?
      order_by :row_order, :asc
    end
    @areas =  search.results
    
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def update_row_order
    @area = Area.find(area_params[:id])
    posIni = @area.row_order.to_i
    posFin = area_params[:row_order].to_i
    if (posIni > posFin)
      Area.where("row_order >= ? and row_order < ? and esa_id = ?", posFin, posIni, area_params[:esa_id]).update_all("row_order = row_order + 1")
    else
      Area.where("row_order > ? and row_order <= ? and esa_id = ?", posIni, posFin, area_params[:esa_id]).update_all("row_order = row_order - 1")
    end
    @area.row_order = posFin
    @area.save
    Area.reindex

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def show
    @int_page_type = 1
  end

  def new
    unless params[:esa_id].nil?
      @esa = Esa.find(params[:esa_id])
    end
    @area = Area.new
    @area.assign_attributes(area_params) if params[:area]
    @int_page_type = 0
  end

  def create
    area = Area.new(area_params)
    area.row_order = area.new_order
    begin
      if area.save
        flash[:notice] = t('messages.successfully_created')
        redirect_to admin_esa_areas_path(area.esa)
      else
        flash[:alert] = get_errors(area)
        redirect_to action: "new", area: area.attributes
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "new", area: area.attributes
    end
  end

  def edit
    @int_page_type = 2
  end

  def update
    begin
      if @area.update_attributes(area_params)
        flash[:notice] = t('messages.successfully_updated')
        redirect_to admin_esa_areas_path(@esa)
      else
        flash[:alert] = get_errors(@area)
        redirect_to action: "edit", id: params[:id]
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "edit", id: params[:id]
    end
  end

  def destroy
    begin
      if @area.delete
        flash[:notice] = t('messages.successfully_deleted')
      else
        flash[:alert] = t('messages.error_ocurred')
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
    end
    redirect_to admin_esa_areas_path(@esa)
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def set_esa
      @esa = @area.esa
    end

    def get_esas
      @esas = Esa.all
    end 
      
    def area_params
      params.require(:area).permit(:id, :title, :esa_id, :icon_image, :reachability, :row_order)
    end
end
