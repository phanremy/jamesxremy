# frozen_string_literal: true

class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :item

  validates :gross_quantity, :net_quantity, :quantity_ratio, presence: true
end
