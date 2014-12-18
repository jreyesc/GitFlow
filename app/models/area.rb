class Area < ActiveRecord::Base
  belongs_to :esa
	has_many :items, dependent: :destroy
	has_many :recommendations, dependent: :destroy
  has_many :recommendation_by_users, dependent: :destroy

	has_attached_file :icon_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icon_image, :content_type => /\Aimage\/.*\Z/

  searchable do
    integer :esa_id
    string :title
    integer :row_order
  end

  def icon_image_url
  	Rails.application.config.action_controller.relative_url_root.to_s + icon_image.url
  end

  def icon_image_thumb
  	Rails.application.config.action_controller.relative_url_root.to_s + icon_image.url(:thumb)
  end


  def self.null?(column)
    columns_hash[column].null
  end

  def new_order
    return Area.where(:esa_id => self.esa_id).count
  end
end
