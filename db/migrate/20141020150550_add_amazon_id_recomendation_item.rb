class AddAmazonIdRecomendationItem < ActiveRecord::Migration
  def change
    add_column :recommendation_items, :amazon_code, :string
  end
end
