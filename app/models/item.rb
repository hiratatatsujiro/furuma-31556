class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :pay_for_shopping
  belongs_to :delivery_area
  belongs_to :days_to_ship
  
  
  with_options presence: true  do
    validates :image
    validates :name
    validates :introduce
    validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Input half-width characters.' }
  end
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range"}

  with_options numericality: { other_than: 1} do
    validates :category_id
    validates :status_id
    validates :pay_for_shopping_id
    validates :delivery_area_id
    validates :days_to_ship_id
  end
end