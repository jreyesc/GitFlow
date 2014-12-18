class Recommendation < ActiveRecord::Base
	belongs_to :area
	has_many :steps, dependent: :destroy
	has_many :recommendation_by_users
	has_many :group_items , through: :recommendation_by_users
	has_many :users , through: :recommendation_by_users
	has_many :recommendation_items, :dependent => :destroy
	after_create :set_data_of_amazon
	after_update :set_data_of_amazon

	has_attached_file :goal_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :url => Rails.application.config.action_controller.relative_url_root.to_s + "/system/:class/:attachment/:id_partition/:style/:basename.:extension", :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension", :default_url => Rails.application.config.action_controller.relative_url_root.to_s + "/images/:style/missing.png"
	validates_attachment_content_type :goal_image, :content_type => /\Aimage\/.*\Z/

	accepts_nested_attributes_for :recommendation_items, :reject_if => lambda { |a| a[:amazon_code].blank? }, :allow_destroy => true

	searchable do
		integer :area_id
	end


	def self.generate_recommendation(item_array,socket_array, area, reachability)
		item_array = item_array.map(&:to_i)
		disabled_array = item_array.collect{ |x| Item.find(x).disabled_item }.uniq.compact
		disabled_array = self.add_childs(disabled_array)
		item_array -= disabled_array
		energy_array = item_array.collect{ |x| Item.find(x).energy_value }
		sum = energy_array.map(&:to_i).inject(:+) || 0
		sockets = socket_array.map(&:to_i).inject(:+)

		all_recommendations = area.recommendations
		min_array = all_recommendations.select{ |x| x.min_energy.to_i <= sum }.select{ |x| x.max_energy.to_i > sum }.sort_by{ |e| e[:total_saving]}.reverse!
		posible_result = nil
		min_array.each do |r|
			recommendation_sockets = (r.total_sockets || 0)
			if recommendation_sockets >= sockets
				if reachability && r.reachability
					return r
				else
					posible_result = r if posible_result.nil?
				end
			end
		end
		return posible_result unless posible_result.nil?
		return min_array.first
	end

	def self.add_childs(array)
		for id in array
			childs = Item.where(parent_id: id).collect{ |x| x.id}
			if childs.size > 0
				array += add_childs(childs)
			end
		end
		return array
	end

	def set_data_of_amazon
		recommendation_items = self.recommendation_items
		recommendation_items.each do |recommendation|
			recommendation.get_data_amazon
		end
	end

	def self.send_mail(email, items)
		UserNotifier.send_list_to_shop(email, items).deliver
	end
end