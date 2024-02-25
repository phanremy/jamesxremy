# frozen_string_literal: true

class Product < ApplicationRecord
  include Products::Sale

  belongs_to :space
  has_many :product_items, dependent: :destroy
  has_many :items, through: :product_items

  accepts_nested_attributes_for :product_items, allow_destroy: true

  validates :description, presence: true, uniqueness: { scope: :space_id }
  validates :price, presence: true

  scope :description_query, lambda { |description|
    return if description.blank?

    where(arel_table[:description].matches("%#{I18n.transliterate(description)}%"))
  }
end
