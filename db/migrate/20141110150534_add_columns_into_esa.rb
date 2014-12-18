class AddColumnsIntoEsa < ActiveRecord::Migration
  def change
  	add_column :esas, :esa_type, :string
  	add_column :esas, :flag_show, :boolean
  end
end
