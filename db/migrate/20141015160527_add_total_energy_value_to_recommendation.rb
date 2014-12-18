class AddTotalEnergyValueToRecommendation < ActiveRecord::Migration
  def change
    add_column :recommendations, :total_energy_value, :integer
  end
end
