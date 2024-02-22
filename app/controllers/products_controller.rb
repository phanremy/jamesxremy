# frozen_string_literal: true

class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :set_spaces
  before_action :set_product, except: %i[index new create]

  def index
    @products = products_query(@space.products.order(:description))
    @pagy, @products = pagy(@products, products: 20)
  end

  def new
    @product = @space.products.build
  end

  def show
    # @items = @product.items
    # @pagy, @items = pagy(@items, items: 20)
  end

  def create
    @product = @space.products.build(product_params)
    if @product.save
      flash[:success] = I18n.t('products.create_success')
      render_product_show
    else
      flash.now[:error] = @product.errors.full_messages
      render_flash
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
      flash.now[:success] = I18n.t('products.update_success')
      render_product_show
    else
      flash.now[:error] = @product.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = I18n.t('products.destroy_success')
      redirect_to space_products_path(space: @space)
    else
      flash.now[:error] = I18n.t('alert.general_error')
      render_flash
    end
  end

  private

  def products_query(products)
    products
  end

  def render_product_show
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'products/main', locals: { product: @product, space: @space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def product_params
    params.require(:product).permit(:description, product_items_ids: [])
  end

  def set_spaces
    @space = Space.find(params[:space_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
