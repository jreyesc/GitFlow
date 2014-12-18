class ChangeTitleToGoalTextOfRecommendation < ActiveRecord::Migration
  def change
  	rename_column :recommendations, :title, :goal_text
  end
end
