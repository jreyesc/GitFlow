class Admin::ItemsController < AdminController
  before_action :get_esas, only: [:index, :show, :create ,:new , :edit, :update, :destroy]

  def index
    unless params[:area_id].blank?
      @area = Area.find(params[:area_id])
      @esa = @area.esa
      @areas = @esa.areas
    end
    search = Item.search do
      with(:parent_id, nil)
      with(:area_id, params[:area_id]) unless params[:area_id].blank?
      order_by :row_order, :asc
    end
    @items =  search.results

    respond_to do |format|
      format.html 
      format.js
    end
  end

  def update_row_order
    @item = Item.find(item_params[:id])
    posIni = @item.row_order.to_i
    posFin = item_params[:row_order].to_i
    if (posIni > posFin)
      Item.where("parent_id IS NULL and area_id = ? and row_order >= ? and row_order < ?", item_params[:area_id], posFin, posIni).update_all("row_order = row_order + 1")
    else
      Item.where("parent_id IS NULL and area_id = ? and row_order > ? and row_order <= ?", item_params[:area_id], posIni, posFin).update_all("row_order = row_order - 1")
    end
    @item.row_order = posFin
    @item.save
    Item.reindex

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def update_areas
    @areas = Area.where("esa_id = ?", params[:esa_id])
    respond_to do |format|
      format.js
    end
  end  

  def create
    if params[:id].blank?
      item = Item.new(area_id: params[:area_id], parent_id: params[:parent_id])
      item.row_order = item.new_order
    else
      item = Item.find(params[:id])
    end
    item.name = params[:name]
    item.energy_value = params[:energy_value] unless params[:itemCollapsable] == "on"
    item.max_sockets = params[:max_sockets] unless params[:itemCollapsable] == "on"
    item.disabled_item = params[:disabled_item] unless params[:itemCollapsable] == "on"
    begin
      if item.save
        flash[:notice] = t('messages.successfully_created')
        redirect_to admin_area_items_path(item.area_id)
      else
        flash[:alert] = get_errors(item)
        redirect_to action: "index", item: item.attributes
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "index", item: item.attributes
    end
  end 

  def destroy
    item = Item.find(params[:id])
    begin
      if item.delete
        Item.where("parent_id IS NULL and area_id = ? and row_order > ?", item.area, item.row_order).update_all("row_order = row_order - 1")
        flash[:notice] = t('messages.successfully_deleted')
        Item.reindex
      else
        flash[:alert] = t('messages.error_ocurred')
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
    end
    redirect_to action: "index"
  end

  private
    def get_esas
      @esas = Esa.all
    end

    def item_params
      params.require(:item).permit(:id, :area_id, :row_order)
    end
end
