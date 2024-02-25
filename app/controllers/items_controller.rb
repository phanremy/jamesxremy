# frozen_string_literal: true

class ItemsController < ApplicationController
  load_and_authorize_resource

  before_action :set_spaces
  before_action :set_item, except: %i[index new create]

  def index
    @items = items_query
    @pagy, @items = pagy(@items, items: 20)
  end

  def new
    @item = @space.items.build
  end

  def show; end

  def create
    @item = @space.items.build(item_params)
    if @item.save
      flash[:success] = I18n.t('items.create_success')
      render_item_show
    else
      flash.now[:error] = @item.errors.full_messages
      render_flash
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      flash.now[:success] = I18n.t('items.update_success')
      render_item_show
    else
      flash.now[:error] = @item.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @item.destroy
      flash[:success] = I18n.t('items.destroy_success')
      redirect_to space_items_path(space: @space)
    else
      render_general_error
    end
  end

  private

  def items_query
    @space.items
          .includes(:supplier)
          .description_or_reference_query(params[:search])
          .supplier_query(params[:supplier_id])
          .order(:supplier_id, :description)
  end

  def render_item_show
    @turbo_stream_data = [
      turbo_stream.update(:space, partial: 'items/main', locals: { item: @item, space: @space }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def item_params
    params.require(:item).permit(
      :description, :reference, :price, :expected_quantity, :actual_quantity, :supplier_id, :unit
    )
  end

  def set_spaces
    @space = Space.find(params[:space_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
