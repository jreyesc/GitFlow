class AddAttachmentMainImageToEsas < ActiveRecord::Migration
  def self.up
    change_table :esas do |t|
      t.attachment :main_image
    end
  end

  def self.down
    remove_attachment :esas, :main_image
  end
end
