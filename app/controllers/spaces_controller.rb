# frozen_string_literal: true

class SpacesController < ApplicationController
  load_and_authorize_resource
  before_action :set_space, only: %i[edit show update]

  def index
    @spaces = Space.accessible_by(current_ability).order(description: :asc)
    @pagy, @spaces = pagy(@spaces, items: 5)
  end

  def show; end

  def new
    @space = Space.new
    @space.owner = current_user
  end

  def create
    @space = Space.new(space_params)
    @space.owner = current_user
    set_extra_attributes
    if @space.save
      flash[:success] = I18n.t('spaces.create_success')
      redirect_to @space
    else
      flash.now[:error] = @space.errors.full_messages
      render_flash
    end
  end

  def edit; end

  def update
    @space.assign_attributes(space_params)
    set_extra_attributes
    if @space.save
      flash.now[:success] = I18n.t('spaces.update_success')
      redirect_to @space
    else
      flash.now[:error] = @space.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @space.destroy
      flash[:success] = I18n.t('spaces.destroy_success')
      redirect_to spaces_path
    else
      render_general_error
    end
  end

  private

  def set_extra_attributes
    @space.extra_units = params.dig(:space, :extra_units)&.split(',')
    @space.software_api_details[:api_key] = @space.api_key
  end

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:description, :software, :api_key, user_ids: [])
  end
end
