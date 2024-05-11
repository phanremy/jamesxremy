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
end
