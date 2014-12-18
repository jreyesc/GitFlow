class Front::CongratulationsController < FrontController
  before_action :set_area

	def show
 		@with_navigation = true
    @group_item_id=RecommendationByUser.where(user_id: current_user.id, recommendation_id: @recommendation_id).first.group_item_id
    @items = ItemsPerGroup.where(group_item_id: @group_item_id ).collect{|x| Item.find(x.item_id)}
    total_energy = @items.collect{ |x| x.energy_value }.map(&:to_i).inject(:+)
    @total_saving = total_energy * @recommendation.total_saving / 100
    @recommendation_items = @recommendation.recommendation_items
	end

	private
    def set_area
      @area_id = params[:id]
      @area = Area.find(@area_id)
      @esa = @area.esa
      @recommendation_id = params[:recommendation]
      @recommendation = Recommendation.find(@recommendation_id.to_i)
    end

end
