# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :space
  has_many :product_items, dependent: :destroy
  has_many :items, through: :product_items

  validates :description, presence: true, uniqueness: { scope: :space_id }
  validates :price, presence: true
end
