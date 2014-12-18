class GroupItem < ActiveRecord::Base
  has_many :items_per_groups
  has_many :items, through: :items_per_groups
  has_many :recommendation_by_users
  has_many :recommendations , through: :recommendation_by_users
  has_many :users , through: :recommendation_by_users

  def item_ids_per_groups
  	items_per_groups.collect{|x| x.item_id}
  end	

end


