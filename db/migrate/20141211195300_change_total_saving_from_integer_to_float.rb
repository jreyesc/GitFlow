class ChangeTotalSavingFromIntegerToFloat < ActiveRecord::Migration
  def change
  	change_column :recommendations, :total_saving, :float
  end
end
