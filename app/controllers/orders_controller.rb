# frozen_string_literal: true

class OrdersController < ApplicationController
  load_and_authorize_resource

  before_action :set_space
  before_action :set_order, except: %i[index new create]

  def index
    @orders = orders_query(@space.orders.includes(:supplier, :items).order(created_at: :desc))
    @pagy, @orders = pagy(@orders, items: 20)
  end

  def new
    @order = @space.orders.build
  end

  def show; end

  def create
    @order = @space.orders.build(order_params)
    if @order.save
      flash[:success] = I18n.t('orders.create_success')
      render_order_show
    else
      flash.now[:error] = @order.errors.full_messages
      render_flash
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    if @order.update(order_params)
      flash.now[:success] = I18n.t('orders.update_success')
      render_order_show
    else
      flash.now[:error] = @order.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = I18n.t('orders.destroy_success')
      redirect_to space_orders_path(space: @space)
    else
      render_general_error
    end
  end

  private

  def orders_query(orders)
    orders
  end

  def render_order_show
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'orders/main', locals: { order: @order, space: @space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def order_params
    params.require(:order).permit(:supplier_id)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
