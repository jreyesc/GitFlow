class ChangeSavePercentageFromIntegerToFloat < ActiveRecord::Migration
  def change
  	change_column :recommendation_items, :save_percentage, :float
  end
end
