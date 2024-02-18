# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :space
  belongs_to :supplier
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  before_save :build_order_items, :set_expected_date

  def build_order_items
    items = supplier.items.where("items.expected_quantity < items.actual_quantity")
    self.order_items = items.map do |item|
      order_items.build(item:, quantity: item.actual_quantity - item.expected_quantity)
    end
  end

  def set_expected_date
    expected_date = Date.today + supplier.expected_day.day +
                    supplier.expected_week.week + supplier.expected_month.month
    self.expected_date = expected_date
  end
end
