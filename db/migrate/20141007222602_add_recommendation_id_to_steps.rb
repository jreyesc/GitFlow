class AddRecommendationIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :recommendation_id, :integer
  end
end
