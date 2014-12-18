class AddIconToArea < ActiveRecord::Migration
  def self.up
    change_table :areas do |t|
      t.attachment :icon_image
    end
  end

  def self.down
    remove_attachment :areas, :icon_image
  end
end
