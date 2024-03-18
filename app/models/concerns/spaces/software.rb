# frozen_string_literal: true

module Spaces
  module Software
    extend ActiveSupport::Concern

    SOFTWARES = %i[none l_addition square tiller zelty].freeze

    included do
      attr_accessor :token, :restaurant_key

      validate :software_already_connected?
      after_commit :connect_to_zelty, if: proc { !software_connected_at? && software == 'zelty' }
    end

    def software_already_connected?
      return false unless software_changed? && software_connected_at?

      errors.add(:software, :already_connected)
    end

    def connect_to_zelty
      Spaces::Zelty.new(self).connect
      self.software_connected_at = Time.current
    rescue StandardError
      # errors.add(:software, I18n.t('alert.general_error'))

      # false
    end
  end
end
