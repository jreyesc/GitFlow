class CreateItemsPerGroups < ActiveRecord::Migration
  def change
    create_table :items_per_groups do |t|
    	t.integer :group_item_id
    	t.integer :item_id
    	
      t.timestamps
    end
  end
end
