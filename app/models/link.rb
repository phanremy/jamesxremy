# frozen_string_literal: true

class Link < ApplicationRecord
  include Sku

  belongs_to :space
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  before_validation :delete_existing_links, :set_attributes, on: :create

  validates :sku, presence: true, uniqueness: true
  validates :space, uniqueness: { scope: :owner_id }
  validates :end_date, presence: true

  def to_param
    sku
  end

  def delete_existing_links
    Link.where(owner_id:, space_id:).destroy_all
  end

  def set_attributes
    self.end_date = DateTime.now + 6.months
    sku = "#{space.description.parameterize}-#{generate_sku(excluded: Link.pluck(:sku))}"
    self.sku = sku
  end

  def genuine?
    # the owner of the link is the owner of the space or is an admin
    (space.owner == owner || owner.admin?) &&
      # the owner is a confirmed user
      owner.confirmed? &&
      # the link is not expired
      (DateTime.now < end_date)
  end
end
