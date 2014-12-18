class AddEsaIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :esa_id, :integer
  end
end
