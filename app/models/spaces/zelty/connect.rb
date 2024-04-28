# frozen_string_literal: true

require 'net/http'

module Spaces
  module Zelty
    class Connect
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

      def connect
        # result = JSON.parse(call).deep_symbolize_keys

        # result[:errno].zero? ? proceed(result) : raise
      end

      def call(from: (Date.today - 1.day).to_s, to: Date.today.to_s,
               offset: 0, limit: 100)
        params = { from:, to:, offset:, limit:, 'expand[]': 'items' }
        @uri.query = URI.encode_www_form(params)
        Net::HTTP.get(@uri, @headers)
      end
    end
  end
end
