class Step < ActiveRecord::Base
	belongs_to :recommendation

  def self.null?(column)
    columns_hash[column].null
  end

  searchable do
    integer :recommendation_id
    string :description
  end

end
