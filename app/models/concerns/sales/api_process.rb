# frozen_string_literal: true

module Sales
  module ApiProcess
    extend ActiveSupport::Concern

    included do
      before_save :process
    end

    def process
      find_or_create_products.each(&:process_sale)
    end

    def find_or_create_products
      details['items'].map do |data|
        space.products
             .create_with(price: data['price']['original_amount_inc_tax'])
             .find_or_create_by(description: data['name'])
      end
    end
  end
end
