# frozen_string_literal: true

module Sku
  extend ActiveSupport::Concern

  def generate_sku(excluded: [])
    result = random_sku.parameterize
    excluded.include?(result) ? raise : result
  rescue StandardError
    @retries ||= 0
    @retries += 1

    @retries < 3 ? retry : errors.add(:sku, 'already taken')
  end

  def random_sku
    [
      (2..100).to_a.sample,
      Faker::Demographic.demonym,
      Faker::Color.color_name,
      Faker::Creature::Animal.name.pluralize
    ].join('-')
  end
end
