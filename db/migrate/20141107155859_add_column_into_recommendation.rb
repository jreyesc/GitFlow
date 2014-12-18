class AddColumnIntoRecommendation < ActiveRecord::Migration
  def change
  	 add_column :recommendations, :title, :text
  end
end
