class AddDisabledItemsToItems < ActiveRecord::Migration
  def change
    add_column :items, :disabled_item, :integer
  end
end
