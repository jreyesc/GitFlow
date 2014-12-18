class RemoveMessageOfEsa < ActiveRecord::Migration
  def change
  	remove_column :esas, :message
  end
end
