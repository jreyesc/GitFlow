class AddAreaIdToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :area_id, :integer
  end
end
