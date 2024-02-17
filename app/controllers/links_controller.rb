# frozen_string_literal: true

class LinksController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: %i[show]
  before_action :set_link, except: %i[create]

  def show
    @space = @link&.space
    @space_user = @space.space_users.build if @space

    if @link&.genuine?
      redirect_to @space if user_signed_in? && @space.confirmed_member?(current_user)
    else
      flash[:error] = I18n.t('links.show_failure')
      redirect_to root_path
    end
    # else link#show
  end

  def create
    @link = Link.new(link_params)
    @link.save ? render_create_success : render_create_failure
  end

  def destroy
    @space = @link.space
    if @link.destroy
      render_destroy_success
    else
      flash.now[:error] = I18n.t('alert.general_error')
      render_flash
    end
  end

  private

  def set_link
    @link = Link.find_by(sku: params[:sku])
  end

  def render_create_success
    flash.now[:success] = I18n.t('links.create_success')
    @turbo_stream_data = [
      turbo_stream.update(:space_link, partial: 'links/url', locals: { link: @link }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def render_create_failure
    flash.now[:error] = I18n.t('alert.general_error')
    @turbo_stream_data = [
      turbo_stream.update(:space_link, partial: 'links/form', locals: { disabled: true }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def render_destroy_success
    flash.now[:success] = I18n.t('links.destroy_success')
    @turbo_stream_data = [
      turbo_stream.update(:space_link, partial: 'links/form', locals: { space: @space, disabled: false }),
      turbo_stream.update('flash', partial: 'shared/flash')
    ]

    render turbo_stream: @turbo_stream_data
  end

  def link_params
    params.require(:link).permit(:space_id, :owner_id)
  end
end
