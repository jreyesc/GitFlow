class AddRowOrderToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :row_order, :integer
  end
end
