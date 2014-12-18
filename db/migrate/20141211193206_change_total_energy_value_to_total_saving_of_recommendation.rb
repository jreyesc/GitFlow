class ChangeTotalEnergyValueToTotalSavingOfRecommendation < ActiveRecord::Migration
  def change
  	rename_column :recommendations, :total_energy_value, :total_saving
  end
end
