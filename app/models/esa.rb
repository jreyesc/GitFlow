class Esa < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  belongs_to :esa_type
  has_attached_file :main_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :url => Rails.application.config.action_controller.relative_url_root.to_s + "/system/:class/:attachment/:id_partition/:style/:basename.:extension", :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension", :default_url => Rails.application.config.action_controller.relative_url_root.to_s + "/images/:style/missing.png"
  validates_attachment_content_type :main_image, :content_type => /\Aimage\/.*\Z/

  has_attached_file :first_section_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :url => Rails.application.config.action_controller.relative_url_root.to_s + "/system/:class/:attachment/:id_partition/:style/:basename.:extension", :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension", :default_url => Rails.application.config.action_controller.relative_url_root.to_s + "/images/:style/missing.png"
  validates_attachment_content_type :first_section_img, :content_type => /\Aimage\/.*\Z/

  has_attached_file :second_section_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :url => Rails.application.config.action_controller.relative_url_root.to_s + "/system/:class/:attachment/:id_partition/:style/:basename.:extension", :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension", :default_url => Rails.application.config.action_controller.relative_url_root.to_s + "/images/:style/missing.png"
  validates_attachment_content_type :second_section_img, :content_type => /\Aimage\/.*\Z/

  # Friendly ID
  # extend FriendlyId
  # friendly_id :title, use: :slugged

  # Pagination: Number of registers per page
  self.per_page = 10

  # Scopes
  scope :all_able, -> { where(deleted: false) }
  
  # This function evaluates if a column is nullable or not in the database
  #
  # * *args*
  #   - column(_string_) -> database column to be evaluated
  # * *returns*
  #   - if the column is nullable or not
  def self.null?(column)
    columns_hash[column].null
  end

  # This function change user state to deleted
  #
  # * *args*
  #   - id -> profile id
  # * *returns*
  #   - if the state update was successful or not
  def delete
    destroy
    # update_attributes(deleted: true)
  end

  # This function check if the register has been deleted or not
  #
  # * *returns*
  #   - if the register is deleted or not
  def deleted?
    deleted == true
  end

  def new_order
    return Esa.count
  end
end
