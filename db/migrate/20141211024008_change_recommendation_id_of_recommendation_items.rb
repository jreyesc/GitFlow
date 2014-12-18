class ChangeRecommendationIdOfRecommendationItems < ActiveRecord::Migration
  def change
  	change_column :recommendation_items, :recommendation_id, :integer, foreign_key: { on_delete: :cascade }
  end
end
