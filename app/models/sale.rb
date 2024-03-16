# frozen_string_literal: true

class Sale < ApplicationRecord
  include Sales::ApiProcess

  STATUS = %w[pending success error in_progress skipped].freeze

  belongs_to :space

  validates :details, presence: true

  def products
    Product.none
  end
end
