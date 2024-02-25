# frozen_string_literal: true

class Supplier < ApplicationRecord
  belongs_to :space
  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :space_id }

  scope :name_query, lambda { |name|
    return if name.blank?

    where(arel_table[:name].matches("%#{I18n.transliterate(name)}%"))
  }

  def delivery_duration
    expected_day.day +
      expected_week.week +
      expected_month.month
  end
end
