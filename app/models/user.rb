class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :recommendation_by_users
  has_many :recommendations , through: :recommendation_by_users
  has_many :group_items , through: :recommendation_by_users
  has_many :areas, through: :recommendation_by_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def recommendation_by_area(area_id)
    recommendations.select{ |x| x.area_id == area_id }.first
  end

  def recommendation_by_user(recommendation_id)
    RecommendationByUser.find_by(user_id: id, recommendation_id: recommendation_id) 
  end
end
