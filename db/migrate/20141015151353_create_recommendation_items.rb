class CreateRecommendationItems < ActiveRecord::Migration
  def change
    create_table :recommendation_items do |t|
			t.string :comment
			t.integer :cost
	  	t.attachment :image_recommendation
	  	t.integer :recommendation_id
	  	t.integer :energy_value
      t.timestamps
    end
  end
end
