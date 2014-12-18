class AddReachabilityIntoRecommendation < ActiveRecord::Migration
  def change
  	add_column :recommendations, :reachability, :boolean 
  end
end
