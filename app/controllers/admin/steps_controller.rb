class Admin::StepsController < AdminController
  before_action :set_step, only: [:show, :edit, :update, :destroy]
  before_action :get_esas, only: [:index]
  before_action :get_recommendations, only: [:index, :show, :create ,:new , :edit, :update, :destroy]
  before_action :set_recommendation, only:[:new]
  before_action :set_recommendation_items, only:[:new, :edit]


  def index
	  unless params[:recommendation_id].nil?
	      @recommendation = Recommendation.find(params[:recommendation_id])
        @area = @recommendation.area
        @esa = @area.esa
        @areas = @esa.areas
        @steps = @recommendation.steps
	  end
	  search = Sunspot.search(Step) do
	    with(:recommendation_id, params[:recommendation_id]) unless params[:recommendation_id].blank?
	  end
	  @steps =  search.results
	  	    
	  respond_to do |format|
		  format.html 
		  format.js
    end
  end

  def show
    @int_page_type = 1
  end

  def new
    @step = Step.new
    @step.assign_attributes(steps_params) if params[:step]
    @int_page_type = 0
  end

  def create
    step = Step.new(steps_params)
    begin
      if step.save
        flash[:notice] = t('messages.successfully_created')
        redirect_to admin_recommendation_steps_path(step.recommendation)
      else
        flash[:alert] = get_errors(area)
        redirect_to action: "new", step: step.attributes
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "new", step: step.attributes
    end
  end

  def edit
    @int_page_type = 2
  end

  def update
    begin
      if @step.update_attributes(steps_params)
        flash[:notice] = t('messages.successfully_updated')
        redirect_to admin_recommendation_steps_path(@step.recommendation)
      else
        flash[:alert] = get_errors(@step)
        redirect_to action: "edit", id: params[:id]
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
      redirect_to action: "edit", id: params[:id]
    end
  end

  def destroy
    begin
      if @step.delete
        flash[:notice] = t('messages.successfully_deleted')
      else
        flash[:alert] = t('messages.error_ocurred')
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
    end
    redirect_to action: "index"
  end


  def update_recommendations
    @recommendations = Recommendation.where("area_id = ?", params[:area_id])
    respond_to do |format|
      format.js
    end
  end  

  private
  	def set_step
      @step = Step.find(params[:id])
      @recommendation = @step.recommendation
    end

    def get_esas
      @esas = Esa.all
    end 

    def get_recommendations
      @recommendations = Recommendation.all
    end

    def steps_params
      params.require(:step).permit(:description,:recommendation_id)
    end

    def set_recommendation
      @recommendation = Recommendation.find(params[:recommendation_id])
    end

    def set_recommendation_items
      recommendation_items = @recommendation.recommendation_items
      @recommendation_items_json = []
      for item in recommendation_items
        @recommendation_items_json << {:label => item.title, :value => {:value => item.id, :content => "<span>#{item.title}</span>" }}
      end
    end
end
