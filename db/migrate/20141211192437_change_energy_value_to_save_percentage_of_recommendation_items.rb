class ChangeEnergyValueToSavePercentageOfRecommendationItems < ActiveRecord::Migration
  def change
  	rename_column :recommendation_items, :energy_value, :save_percentage
  end
end
