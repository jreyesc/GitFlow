class AddSocketsToItemsPerGroups < ActiveRecord::Migration
  def change
    add_column :items_per_groups, :sockets, :integer
  end
end
