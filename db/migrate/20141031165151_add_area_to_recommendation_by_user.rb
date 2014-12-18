class AddAreaToRecommendationByUser < ActiveRecord::Migration
  def change
    add_column :recommendation_by_users, :area_id, :integer
  end
end
