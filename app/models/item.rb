class Item < ActiveRecord::Base
	belongs_to :area
	has_many :items_per_groups
	has_many :group_items, through: :items_per_groups
	has_many :items, :foreign_key => "parent_id", :dependent => :destroy

	searchable do
		integer :area_id
		string :name
		integer :parent_id
		integer :row_order
	end

	def items_per_group(group_item_id)
		self.items_per_groups.where(group_item_id: group_item_id)
	end

	def self.null?(column)
		columns_hash[column].null
	end

  def new_order
    return Item.where(:parent_id => nil).where(:area_id => self.area_id).count
  end
end