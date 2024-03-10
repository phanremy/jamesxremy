# frozen_string_literal: true

module Sales
  module ApiProcess
    extend ActiveSupport::Concern

    included do
      before_save :process
    end

    def process
      products.each(&:process_sale)
    end
  end
end
