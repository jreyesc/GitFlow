class AddEnergyRangeToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :min_energy, :integer
    add_column :recommendations, :max_energy, :integer
  end
end
