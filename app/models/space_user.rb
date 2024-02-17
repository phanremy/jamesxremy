# frozen_string_literal: true

class SpaceUser < ApplicationRecord
  belongs_to :space
  belongs_to :user

  validates :user_id, uniqueness: { scope: :space_id }
  accepts_nested_attributes_for :user
end
