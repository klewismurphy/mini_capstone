class Order < ApplicationRecord
  belongs_to :user
  # belongs_to :product
  has_many :cartedproducts
  # has_many :products, through: :cartedproducts
end
