class Front::ShareController < FrontController
	before_action :set_area, only: [:show]

  def show
	  @recommendation = Recommendation.find(params[:recommendation].to_i)
 	  @with_navigation = true
 	  @esa = @area.esa
  end

  private
    def set_area
      @area = Area.find(params[:id].to_i)
    end
end
