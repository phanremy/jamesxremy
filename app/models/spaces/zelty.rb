# frozen_string_literal: true

module Spaces
  class Zelty
    attr_reader :space

    def initialize(space)
      @space = space
    end

    def connect
      @space.software_api_details[:api_key]
    end
  end
end
