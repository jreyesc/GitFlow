class Admin::EsaTypesController < AdminController
	before_action :set_esa_type, only: [:show, :edit, :update, :destroy]
  
  def index
    @esa_types = EsaType.all.paginate(:page => params[:page])
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def show
    @int_page_type = 1
  end

  def new
    @esa_type = EsaType.new
    @esa_type.assign_attributes(esa_type_params) if params[:esa]
    @int_page_type = 0
  end

  def create
    esa_type = EsaType.new(esa_type_params)
    begin
      if esa_type.save
        flash[:notice] = t('messages.successfully_created')
        redirect_to action: "index"
      else
        flash[:alert] = get_errors(esa_type)
        redirect_to action: "new", esa_type: esa_type.attributes
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "new", esa_type: esa.attributes
    end
  end

  def edit
    @int_page_type = 2
  end

  def update
    begin
      if @esa_type.update_attributes(esa_type_params)
        flash[:notice] = t('messages.successfully_updated')
        redirect_to action: "index"
      else
        flash[:alert] = get_errors(@esa_type)
        redirect_to action: "edit", id: params[:id]
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "edit", id: params[:id]
    end
  end

  def destroy
    begin
      if @esa_type.delete
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

    def esa_type_params
      params.require(:esa_type).permit(:name)
    end

    def set_esa_type
      @esa_type = EsaType.find(params[:id])
    end

end
