# frozen_string_literal: true

class Sale < ApplicationRecord
  include Sales::ApiProcess

  STATUS = %w[pending success error in_progress skipped].freeze

  belongs_to :space

  validates :uid, :details, presence: true

  def products_list
    return Product.none unless space.software == 'zelty'

    details['items'].map do |data|
      space.products.find_by(description: data['name'])
    end
  end

  def products
    dig_zelty_item_details(:name) if space.zelty?
  end

  def product_ids
    dig_zelty_item_details(:id) if space.zelty?
  end

  def prices
    details['price'] if space.zelty?
  end

  private

  def dig_zelty_item_details(stuff)
    return [] unless details['items']&.any?

    details['items'].map { |item| item[stuff.to_s] }

  end
end
