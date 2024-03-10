# frozen_string_literal: true

class Sale < ApplicationRecord
  include Sales::ApiProcess

  belongs_to :space

  validates :details, presence: true

  def products
    Product.none
  end
end
