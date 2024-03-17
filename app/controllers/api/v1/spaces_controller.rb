# frozen_string_literal: true

module Api
  module V1
    class SpacesController < Api::V1::BaseController
      before_action :set_space, only: %i[show]

      def index
        @spaces = Space.all
      end

      def show; end

      private

      def set_space
        @space = Space.find(params[:id])
      end
    end
  end
end
