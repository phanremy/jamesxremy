# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :space
  has_many :product_items, dependent: :destroy
  has_many :items, through: :product_items

  accepts_nested_attributes_for :product_items, allow_destroy: true

  validates :description, presence: true, uniqueness: { scope: :space_id }
  validates :price, presence: true
end
