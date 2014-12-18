class AddAreasMessageToEsas < ActiveRecord::Migration
  def change
    add_column :esas, :areas_message, :string
  end
end
