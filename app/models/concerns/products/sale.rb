# frozen_string_literal: true

module Products
  module Sale
    extend ActiveSupport::Concern

    # false is removing a sale and adding back item quantity
    def process_sale(sale: true)
      Product.transaction do
        increment = sale ? 1 : -1
        update!(sales_count: sales_count + increment)
        product_items.each do |product_item|
          increment = sale ? -1 * product_item.quantity : product_item.quantity
          item = product_item.item
          item.update!(actual_quantity: item.actual_quantity + increment)
        end
      end
    end
  end
end
