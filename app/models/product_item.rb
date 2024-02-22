# frozen_string_literal: true

class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :item

  validates :quantity, presence: true
end
