class AddTotalSocketsIntoRecommendation < ActiveRecord::Migration
  def change
  	add_column :recommendations, :total_sockets, :integer
  end
end
