class Front::RecommendationsController < FrontController
  before_action :set_recommendation_user, :set_recommendation
  before_action :set_area, :set_esa, :set_cmb_recommendations, only: [:show, :purchase, :steps, :share]
  
  def show
    total_energy = @recommendation_user.group_item.items.collect{ |x| x.energy_value }.map(&:to_i).inject(:+)
    @total_saving = total_energy * @recommendation.total_saving / 100
    @areas = current_user.areas.where(esa_id: @esa.id)
  end

  def purchase
    @recommendation_items = @recommendation.recommendation_items
    @areas = current_user.areas.where(esa_id: @esa.id)
  end

  def steps
    @steps = @recommendation.steps
    @areas = current_user.areas.where(esa_id: @esa.id)
  end

  def share
  end

  def send_mail
    recommendation_items = @recommendation.recommendation_items.collect{ |x| x.id }
    Recommendation.delay.send_mail(params[:email], recommendation_items)
    render json: { success: true }
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
end
