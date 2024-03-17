# frozen_string_literal: true

module Products
  class SalesController < ApplicationController
    authorize_resource class: false
    before_action :set_product

    def create
      if @product.process_sale
        flash.now[:success] = I18n.t('products.sales.create_success')
        render_product_show
      else
        render_general_error
      end
    end

    def destroy
      if @product.process_sale(sale: false)
        flash.now[:success] = I18n.t('products.sales.destroy_success')
        render_product_show(sale: false)
      else
        render_general_error
      end
    end

    private

    def render_product_show(sale: true)
      @turbo_stream_data = [
        turbo_stream.update(:"product_#{@product.id}_sales_count", @product.sales_count),
        turbo_stream.update(:sale, partial: 'sales/main', locals: { product: @product, space: @product.space, sale: }),
        turbo_stream.update('flash', partial: 'shared/flash')
      ]

      render turbo_stream: @turbo_stream_data
    end

    def set_product
      @product = Product.find(params[:product_id])
    end
  end
end
