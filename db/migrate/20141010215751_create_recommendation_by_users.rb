class CreateRecommendationByUsers < ActiveRecord::Migration
  def change
    create_table :recommendation_by_users do |t|
    	t.integer :user_id
      t.integer :group_item_id
      t.integer :recommendation_id
      
      t.timestamps
    end
  end
end
