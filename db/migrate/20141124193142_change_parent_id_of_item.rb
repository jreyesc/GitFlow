class ChangeParentIdOfItem < ActiveRecord::Migration
  def change
  	change_column :items, :parent_id, :integer, foreign_key: { on_delete: :cascade }
  end
end
