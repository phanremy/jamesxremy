# frozen_string_literal: true

class Space < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  validates :description, presence: true, uniqueness: { scope: :owner_id }
  has_many :space_users, dependent: :destroy
  has_many :users, through: :space_users
  has_many :links, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suppliers, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :sales, dependent: :destroy

  attr_accessor :api_key

  SOFTWARES = %i[none l_addition square tiller zelty].freeze

  # TODO: check if extra_units deleted are not used

  def members
    users.including(owner)
  end

  def confirmed_member?(user)
    user.confirmed? && members.include?(user)
  end

  def unconfirmed_member?(user)
    !user.confirmed? && members.include?(user)
  end
end
