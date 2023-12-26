class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :category_restaurants
  has_many :categories, through: :category_restaurants
  # 1 restaurant puede tener 1 o varias categorías en la tabla category_restaurant

  has_one_attached :photo

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
