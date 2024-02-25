# frozen_string_literal: true

class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :item

  validates :gross_quantity, :net_quantity, :quantity_ratio, presence: true

  before_save :set_quantity_ratio

  # TODO: gross_quantity >= net_quantity

  def set_quantity_ratio
    self.quantity_ratio = net_quantity.fdiv(gross_quantity).round(2)
  end
end
