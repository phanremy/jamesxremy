# frozen_string_literal: true

module Spaces
  module Software
    extend ActiveSupport::Concern

    SOFTWARES = %i[none l_addition square tiller zelty].freeze

    included do
      attr_accessor :token, :restaurant_key

      validate :software_already_connected?
      after_commit :link_with_zelty, if: proc { !software_connected_at? && software == 'zelty' }
    end

    def software_already_connected?
      return false unless software_changed? && software_connected_at?

      errors.add(:software, :already_connected)
    end

    def link_with_zelty
      Spaces::Zelty::Import.new(self).import
      Spaces::Zelty::Connect.new(self).connect
      self.software_connected_at = Time.current
    rescue StandardError
      # errors.add(:software, I18n.t('alert.general_error'))

      # false
    end
  end
end
