class ShoppingInformation < ApplicationRecord
  belongs_to :purchase
  attr_accessor :token
end
