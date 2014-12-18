class AddEsaTypeIntoEsa < ActiveRecord::Migration
  def change
  	add_column :esas, :esa_type_id, :integer
  end
end
