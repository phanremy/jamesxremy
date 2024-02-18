# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :space
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates :supplier, presence: true
  validates :actual_quantity, :expected_quantity, presence: true
end
