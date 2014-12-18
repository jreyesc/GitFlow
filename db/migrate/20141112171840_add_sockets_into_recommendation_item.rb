class AddSocketsIntoRecommendationItem < ActiveRecord::Migration
  def change
  	add_column :recommendation_items, :sockets, :integer 	
  end
end
