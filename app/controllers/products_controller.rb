# frozen_string_literal: true

class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :set_spaces
  before_action :set_product, except: %i[index new create]

  def index
    @products = products_query
    @pagy, @products = pagy(@products, products: 20)
  end

  def new
    @product = @space.products.build
    @product.product_items.build
  end

  def show; end

  def create
    @product = @space.products.build(product_params)

    respond_to do |format|
      if params[:commit].present? && @product.save
        flash[:success] = I18n.t('products.create_success')
        format.turbo_stream { redirect_to space_product_path(@product, space_id: @space.id) }
      else
        build_product_attributes
        format.turbo_stream { render_turbo_stream }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product.assign_attributes(product_params)

    respond_to do |format|
      if params[:commit].present? && @product.save
        flash[:success] = I18n.t('products.update_success')
        format.html { redirect_to space_product_path(@product, space_id: @space.id) }
      else
        build_product_attributes
        format.turbo_stream { render_turbo_stream }
      end
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = I18n.t('products.destroy_success')
      redirect_to space_products_path(space: @space)
    else
      render_general_error
    end
  end

  private

  def products_query
    @space.products
          .description_query(params[:search])
          .order(:description)
  end

  def build_product_attributes
    @field_submitter = params.dig(:product, :field_submitter)
    @product.product_items.build if params[:add_item]
  end

  def render_turbo_stream
    flash.now[:error] = @product.errors.full_messages if @product.errors.any?
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'products/form', locals: { product: @product, space: @product.space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def product_params
    params.require(:product).permit(
      :description,
      product_items_attributes: %i[id product_id item_id gross_quantity net_quantity quantity_ratio _destroy]
    )
  end

  def set_spaces
    @space = Space.find(params[:space_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
