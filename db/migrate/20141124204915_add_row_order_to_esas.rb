class AddRowOrderToEsas < ActiveRecord::Migration
  def change
    add_column :esas, :row_order, :integer
  end
end
