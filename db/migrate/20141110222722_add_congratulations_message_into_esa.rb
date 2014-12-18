class AddCongratulationsMessageIntoEsa < ActiveRecord::Migration
  def change
	add_column :esas, :congratulations_message , :text
  end
end
