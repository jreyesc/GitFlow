#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class Admin::RecommendationsController < AdminController
  before_action :set_recommendation, only: [:show, :edit, :update, :destroy]
  before_action :get_esas, only: [:index]
  before_action :set_area, only:[:new]

  def index
    unless params[:area_id].nil?
        @area = Area.find(params[:area_id])
        @esa = @area.esa
        @areas = @esa.areas
        @recommendation = Recommendation.find(params[:area_id])
    end
    search = Sunspot.search(Recommendation) do
      with(:area_id, params[:area_id]) unless params[:area_id].blank?
    end
    @recommendations =  search.results
          
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def new
    @int_page_type = 0
    @recommendation = Recommendation.new
    1.times do
      item_recommendation = @recommendation.recommendation_items.build
    end  
  end

  def create
	  @recommendation = Recommendation.new(recommendation_params) 
	  @recommendation.save
	  redirect_to admin_area_recommendations_path(@recommendation.area)
  end

  def edit
    @area = @recommendation.area
    @int_page_type = 2
  end

  def update
    @recommendation = Recommendation.find(params[:id])
    @recommendation.update_attributes(recommendation_params)
    flash[:notice] = t('messages.successfully_created')
    redirect_to :action=>"show", id: params[:id]
  end

  def show
    @area = @recommendation.area
    @int_page_type = 1
    @recommendation = Recommendation.find(params[:id])
  end

  def destroy
    begin
      if @recommendation.delete
        flash[:notice] = t('messages.successfully_deleted')
      else
        flash[:alert] = t('messages.error_ocurred')
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
    end
    redirect_to admin_area_recommendations_path(@recommendation.area)
  end

  private
    def recommendation_params
      p params
      params.require(:recommendation).permit(:area_id, :goal_text, :goal_image, :min_energy, :max_energy, :total_saving, :total_sockets, :reachability, recommendation_items_attributes: [:id, :amazon_code, :comment, :save_percentage, :sockets,:_destroy])
    end

    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end

    def get_esas
      @esas = Esa.all
    end

    def set_area
      @area = Area.find(params[:area_id])
    end 


end
