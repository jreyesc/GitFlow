class AddReachabilityToGroupItems < ActiveRecord::Migration
  def change
    add_column :group_items, :reachability, :boolean
  end
end
