class AddReachabilityToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :reachability, :boolean
  end
end
