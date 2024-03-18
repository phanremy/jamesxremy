# frozen_string_literal: true

class Space < ApplicationRecord
  include Spaces::Software

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

  # TODO: check if extra_units deleted are not used

  def total_final_amount_inc_tax
    sales.pluck(:final_amount_inc_tax).sum
  end

  def total_final_amount_exc_tax
    sales.pluck(:final_amount_exc_tax).sum
  end

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
