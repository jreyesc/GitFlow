class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
			t.string :comment
			t.integer :cost
	  	t.attachment :image_recommendation
      t.timestamps
    end
  end
end
