# frozen_string_literal: true

module Orders
  module Purchase
    extend ActiveSupport::Concern

    # status either delivered or pending
    def purchase_transaction(status: :delivered)
      Order.transaction do
        update!(status:,
                delivered_at: status == :delivered ? Date.today : nil)
        update_items(status)
        # raise ActiveRecord::Rollback
      end
    end

    private

    def update_items(status)
      ratio = status == :delivered ? 1 : -1
      order_items.each do |order_item|
        actual_quantity = order_item.item.actual_quantity + (order_item.quantity * ratio)
        order_item.item.update!(actual_quantity:)
      end
    end
  end
end
