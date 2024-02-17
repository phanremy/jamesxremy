# frozen_string_literal: true

class Supplier < ApplicationRecord
  belongs_to :space
  validates :name, presence: true, uniqueness: { scope: :space_id }
end
