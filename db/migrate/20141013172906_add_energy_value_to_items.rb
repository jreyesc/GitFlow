class AddEnergyValueToItems < ActiveRecord::Migration
  def change
    add_column :items, :energy_value, :integer
  end
end
