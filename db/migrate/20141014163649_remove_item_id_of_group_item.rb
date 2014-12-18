class RemoveItemIdOfGroupItem < ActiveRecord::Migration
  def up
    remove_column :group_items, :item_id
  end
end
