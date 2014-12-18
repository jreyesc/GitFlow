class AddNameToRecommendationByUser < ActiveRecord::Migration
  def change
    add_column :recommendation_by_users, :name, :string
  end
end
