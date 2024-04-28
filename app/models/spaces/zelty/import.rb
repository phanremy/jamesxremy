# frozen_string_literal: true

require 'net/http'

module Spaces
  module Zelty
    class Import
      attr_reader :space

      def initialize(space)
        @space = space
        @uri = URI.parse("https://api.zelty.fr/2.7/orders")
        token = @space.software_api_details['token']
        @headers = {
          'Authorization' => "Bearer #{token}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      end

      def import
        result = JSON.parse(call).deep_symbolize_keys

        result[:errno].zero? ? proceed(result) : raise
      end

      def call(from: (Date.today - 1.day).to_s, to: Date.today.to_s,
               offset: 0, limit: 100)
        params = { from:, to:, offset:, limit:, 'expand[]': 'items' }
        @uri.query = URI.encode_www_form(params)
        Net::HTTP.get(@uri, @headers)
      end

      private

      # convert the last 10 orders into sales
      def proceed(result)
        result[:orders].reverse.each do |order|
          base_sale.create_with(
            details: order,
            status: order[:status],
            final_amount_inc_tax: order.dig(:price, :final_amount_inc_tax),
            final_amount_exc_tax: order.dig(:price, :final_amount_exc_tax),
            created_at: order[:created_at]
          ).find_or_create_by!(uuid: order[:uuid], uid: order[:id])
        end
      end

      def base_sale
        Sale.create_with(
          space_id: @space.id,
          kind: 'ZeltyNotification',
          webhook_identifier: 'zelty',
          event: 'order/closed'
        )
      end
    end
  end
end
