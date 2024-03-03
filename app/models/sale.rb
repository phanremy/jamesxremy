# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :space

  validates :details, presence: true
end
