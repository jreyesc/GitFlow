class Front::StepsController < FrontController
  before_action :set_recommendation_user, :set_recommendation
  before_action :set_area, :set_esa, :set_cmb_recommendations, only: [:show, :purchase, :steps, :share]
	before_action :set_area, only: [:show]

  def show
  	@steps = @recommendation.steps
 		@with_navigation = true
 	  @esa = @area.esa
    @areas = current_user.areas
  end

  private
    def set_recommendation
      @recommendation = @recommendation_user.recommendation
    end

    def set_recommendation_user
      @recommendation_user = RecommendationByUser.find(params[:id])
    end

    def set_cmb_recommendations
      @recommendations = current_user.recommendation_by_users.includes(:area).where(areas: { esa_id: @esa.id })
    end

    def set_area
      @area = @recommendation.area
    end

    def set_esa
      @esa = @area.esa
    end

    def set_area
      @area_id = params[:id]
      @area = Area.find(@area_id)
      @recommendation_id = params[:recommendation]
      @recommendation = Recommendation.find(@recommendation_id)
    end
end
