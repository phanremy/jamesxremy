# frozen_string_literal: true

module Spaces
  module Software
    extend ActiveSupport::Concern

    SOFTWARES = %i[none l_addition square tiller zelty].freeze

    included do
      attr_accessor :api_key, :restaurant_key

      validate :software_already_connected?
      before_save :connect_to_zelty, if: proc { !software_connected_at? && software == 'zelty' }
    end

    def software_already_connected?
      return false unless software_changed? && software_connected_at?

      errors.add(:software, :already_connected)
    end

    def connect_to_zelty
      Spaces::Zelty.new(self).connect
      self.software_connected_at = Time.current
    end
  end
end
