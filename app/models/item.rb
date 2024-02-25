# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :space
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_items, dependent: :destroy
  has_many :products, through: :product_items

  validates :supplier, presence: true
  validates :description, :reference, :price, :actual_quantity, :expected_quantity, presence: true

  DEFAULT_UNIT = 'unit'
  UNITS = %w[piece kilo box package bottle carton lot].push(DEFAULT_UNIT).freeze

  def variance_quantity
    actual_quantity - expected_quantity
  end
end
