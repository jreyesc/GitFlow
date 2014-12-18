class AddAttachmentFirstSectionImgToEsas < ActiveRecord::Migration
  def self.up
    change_table :esas do |t|
      t.attachment :first_section_img
    end
  end

  def self.down
    remove_attachment :esas, :first_section_img
  end
end
