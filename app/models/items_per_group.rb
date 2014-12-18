class ItemsPerGroup < ActiveRecord::Base
	belongs_to :item
  belongs_to :group_item

  def self.news_items_per_group(group_item_id, item_ids, item_sockets)
  	item_ids.each_with_index{ |item_id, i| ItemsPerGroup.create(group_item_id: group_item_id, item_id: item_id, sockets: item_sockets[i.to_i]) } 
  end
end
