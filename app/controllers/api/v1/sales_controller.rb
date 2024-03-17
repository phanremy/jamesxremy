# frozen_string_literal: true

module Api
  module V1
    class SalesController < Api::V1::BaseController
      before_action :set_space, only: %i[show]

      def create
        @space.sales.new(sale_params)
        if @sale.save
          render status: :ok
        else
          render json: { message: @sale.errors.full_messages, status: 400 },
                 status: :bad_request
        end
      end

      private

      def sale_params
        params.require(:sale).permit(:details)
      end

      def set_space
        @space = Space.find(params[:space_id])
      end
    end
  end
end
