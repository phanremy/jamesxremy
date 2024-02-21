# frozen_string_literal: true

class PurchasesController < ApplicationController
  authorize_resource class: false
  before_action :set_order

  def create
    if @order.update(status: :delivered)
      flash.now[:success] = I18n.t('purchases.create_success')
      render_space_show
    else
      render_error
    end
  end

  def update
    if @order.update(status: :pending)
      flash.now[:success] = I18n.t('purchases.update_success')
      render_space_show
    else
      render_error
    end
  end

  def destroy
    if @order.update(status: :cancelled)
      flash.now[:success] = I18n.t('purchases.destroy_success')
      render_space_show
    else
      render_error
    end
  end

  private

  def render_space_show
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'orders/main', locals: { order: @order, space: @order.space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def render_error
    flash.now[:error] = I18n.t('alert.general_error')
    render_flash
  end

  def set_order
    @order = Order.find(params[:order_id])
  end
end
