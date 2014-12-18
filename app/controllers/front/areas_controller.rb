class Front::AreasController < FrontController
  before_action :set_esa, except: :user_recommendation
  before_action :set_area, except: :index
  before_action :set_recommendations, except: :index

  def index
    @areas = @esa.areas.order('row_order ASC')
    @recommendations = current_user.recommendation_by_users.includes(:area).where(areas: { esa_id: @esa.id }).sort_by{ |e| e[:created_at]}
  end

  def show
    flash[:notice] = nil unless flash[:notice] == t('messages.no_recommendation')
    flash[:alert] = nil
    flash[:warning] = nil
    flash[:information] = nil
    @items = @area.items.where('parent_id' => nil).order('row_order ASC')
  end

  def edit
    flash[:notice] = nil unless flash[:notice] == t('messages.no_recommendation')
    flash[:alert] = nil
    flash[:warning] = nil
    flash[:information] = nil
    @recommendation_by_user = RecommendationByUser.find(params[:recommendation_by_user])
    @items = @area.items.where('parent_id' => nil).order('row_order ASC')
    @group_item = @recommendation_by_user.group_item
  end

  def create
    group_item = GroupItem.new
    group_item.reachability = params[:reachability]
    unless group_item.save
      redirect_to [:front, @esa, @area]
    else
      ItemsPerGroup.news_items_per_group(group_item.id, params[:item_ids], params[:item_sockets])
      recommendation =  Recommendation.generate_recommendation(params[:item_ids], params[:item_sockets], @area, group_item.reachability)
      if recommendation.nil?
        flash[:notice] = t('messages.no_recommendation')
        redirect_to [:front, @esa, @area]
      else
        @recommendation_by_user = RecommendationByUser.new(user: current_user, area: @area)
        @recommendation_by_user.group_item = group_item
        @recommendation_by_user.recommendation = recommendation
        number = 1
        number = @recommendations.count unless @recommendations.nil?
        @recommendation_by_user.name = number + 1
        unless @recommendation_by_user.save
          redirect_to [:front,@esa, @area]
        else
          redirect_to [:front, @recommendation_by_user]
        end
      end
    end
  end

  def update
    group_item = GroupItem.find_or_initialize_by(id: params[:group_item_id])
    group_item.reachability = params[:reachability]
    unless group_item.save
      redirect_to [:front, @esa, @area]
    else
      ItemsPerGroup.where(:group_item_id => group_item.id).destroy_all
      ItemsPerGroup.news_items_per_group(group_item.id, params[:item_ids], params[:item_sockets])
      recommendation =  Recommendation.generate_recommendation(params[:item_ids], params[:item_sockets], @area, group_item.reachability)
      @recommendation_by_user = RecommendationByUser.find_or_initialize_by(user: current_user, area: @area, group_item: group_item)
      if recommendation.nil?
        flash[:notice] = t('messages.no_recommendation')
        redirect_to [:front,@esa, @area, @recommendation_by_user]
      else
        @recommendation_by_user.group_item = group_item
        @recommendation_by_user.recommendation = recommendation
        unless @recommendation_by_user.save
          redirect_to [:front,@esa, @area]
        else
          redirect_to [:front, @recommendation_by_user]
        end
      end
    end
  end

  private
    def set_esa
      @esa = Esa.find(params[:esa_id])
    end

    def set_area
      area_id = params[:id] || params[:area_id]
      p "ss"
      p area_id
      @area = Area.find_by(id: area_id, esa: @esa)
    end

    def set_recommendations
      @recommendations = current_user.recommendation_by_users.where('area' => @area)
    end
end

