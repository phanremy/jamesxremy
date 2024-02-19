# frozen_string_literal: true

class SuppliersController < ApplicationController
  load_and_authorize_resource

  before_action :set_spaces
  before_action :set_supplier, except: %i[index new create]

  def index
    @suppliers = suppliers_query(@suppliers = @space.suppliers.order(created_at: :desc))
    @pagy, @suppliers = pagy(@suppliers, items: 20)
  end

  def new
    @supplier = @space.suppliers.build
  end

  def show
    @items = @supplier.items
    @pagy, @items = pagy(@items, items: 20)
  end

  def create
    @supplier = @space.suppliers.build(supplier_params)
    if @supplier.save
      flash[:success] = I18n.t('suppliers.create_success')
      render_supplier_show
    else
      flash.now[:error] = @supplier.errors.full_messages
      render_flash
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    if @supplier.update(supplier_params)
      flash.now[:success] = I18n.t('suppliers.update_success')
      render_supplier_show
    else
      flash.now[:error] = @supplier.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @supplier.destroy
      flash[:success] = I18n.t('suppliers.destroy_success')
      redirect_to space_suppliers_path(space: @space)
    else
      flash.now[:error] = I18n.t('alert.general_error')
      render_flash
    end
  end

  private

  def suppliers_query(suppliers)
    suppliers
  end

  def render_supplier_show
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'suppliers/main', locals: { supplier: @supplier, space: @space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def supplier_params
    params.require(:supplier).permit(:name, :expected_day, :expected_week, :expected_month)
  end

  def set_spaces
    @space = Space.find(params[:space_id])
  end

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
end
