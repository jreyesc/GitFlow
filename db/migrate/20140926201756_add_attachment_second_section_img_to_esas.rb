class AddAttachmentSecondSectionImgToEsas < ActiveRecord::Migration
  def self.up
    change_table :esas do |t|
      t.attachment :second_section_img
    end
  end

  def self.down
    remove_attachment :esas, :second_section_img
  end
end
