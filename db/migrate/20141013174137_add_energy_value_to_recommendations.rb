class AddEnergyValueToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :energy_value, :integer
  end
end
