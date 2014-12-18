class UpdateRemoveColumsOfRecommendation < ActiveRecord::Migration
  def up
    remove_column :recommendations, :comment
    remove_column :recommendations, :cost
    drop_attached_file :recommendations, :image_recommendation
  end
end
