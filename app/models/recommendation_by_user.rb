class RecommendationByUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_item
  belongs_to :recommendation
  belongs_to :area

  def self.new_register(current_user, recommendation_id, group_item_id)
  	create(user_id: current_user.id, group_item_id: group_item_id, recommendation_id: recommendation_id)
  end

  def update(params={})
  	self.user_id = params[:user_id] unless params[:user_id].nil?
  	self.recommendation_id = params[:recommendation_id] unless params[:recommendation_id].nil?
  	self.group_item_id = params[:group_item_id] unless params[:group_item_id].nil?
  	self.save
  end
end
