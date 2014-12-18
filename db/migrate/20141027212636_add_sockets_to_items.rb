class AddSocketsToItems < ActiveRecord::Migration
  def change
    add_column :items, :max_sockets, :integer
  end
end
