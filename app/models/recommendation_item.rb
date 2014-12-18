class RecommendationItem < ActiveRecord::Base
	belongs_to :recommendation

	def get_data_amazon
		res = Amazon::Ecs.item_lookup(amazon_code, :response_group => 'Small, ItemAttributes, Images')

		res.items.each do |item|
			# retrieve string value using XML path
			item.get('ASIN')
			item.get('ItemAttributes/Title')

			# return Amazon::Element instance
			item_attributes = item.get_element('ItemAttributes')
			# item_attributes.get_array('Feature')
			#self.comment = item.get_element('ItemAttributes')

			self.features = item_attributes.get_array('Feature').collect{ |x| x}.join(". <br><br>")

			self.title = item_attributes.get('Title')

			self.price = item_attributes.get_element('ListPrice').get('FormattedPrice') unless item_attributes.get_element('ListPrice').nil?
				
			unless item.get_hash('LargeImage')["URL"].nil?
				self.image_url = item.get_hash('LargeImage')["URL"]
			else
				self.image_url = item.get_hash('MediumImage')["URL"]
			end

			self.save

			p item.get_hash('MediumImage')
			p "http://www.amazon.com/dp/#{item.get('ASIN')}"
		end
	end
end