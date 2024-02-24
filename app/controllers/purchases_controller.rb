# frozen_string_literal: true

class PurchasesController < ApplicationController
  authorize_resource class: false
  before_action :set_order

  def create
    if @order.purchase_transaction(status: :delivered)
      flash.now[:success] = I18n.t('purchases.create_success')
      render_order_show
    else
      render_general_error
    end
  end

  def update
    if @order.purchase_transaction(status: :pending)
      flash.now[:success] = I18n.t('purchases.update_success')
      render_order_show
    else
      render_general_error
    end
  end

  def destroy
    if @order.update(status: :cancelled)
      flash.now[:success] = I18n.t('purchases.destroy_success')
      render_order_show
    else
      render_general_error
    end
  end

  private

  def render_order_show
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'orders/main', locals: { order: @order, space: @order.space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def set_order
    @order = Order.find(params[:order_id])
  end
end
