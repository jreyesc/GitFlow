class EsaType < ActiveRecord::Base
	has_many :esa, dependent: :destroy
end
