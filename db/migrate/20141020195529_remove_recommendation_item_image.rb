class RemoveRecommendationItemImage < ActiveRecord::Migration
  def change
  	drop_attached_file :recommendation_items, :image_recommendation
  	add_column :recommendation_items, :image_url, :string
  	add_column :recommendation_items, :features, :text
  	add_column :recommendation_items, :title, :text
  	add_column :recommendation_items, :price, :text
  end


end
