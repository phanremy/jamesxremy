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
    assign_extra_attributes
    render_form(:create)
  end

  def edit
    set_assign_attributes
  end

  def update
    @space.assign_attributes(space_params)
    assign_extra_attributes
    render_form(:update)
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

  def set_assign_attributes
    %i[token restaurant_key].each do |key|
      @space.assign_attributes("#{key}": @space.software_api_details[key.to_s])
    end
  end

  def assign_extra_attributes
    @space.extra_units = params.dig(:space, :extra_units)&.split(',')
    %i[token restaurant_key].each do |key|
      if @space.send(key).present?
        @space.software_api_details[key.to_s] = @space.send(key)
      else
        @space.software_api_details.delete(key.to_s)
      end
    end
  end

  def render_form(method)
    respond_to do |format|
      if params[:commit].present? && @space.save
        flash[:success] = I18n.t("spaces.#{method}_success")
        format.html { redirect_to @space }
      else
        build_spaces_attributes
        format.turbo_stream { render_form_turbo_stream(**form_locals) }
      end
    end
  end

  def build_spaces_attributes
    @field_submitter = params.dig(:space, :field_submitter)
  end

  def form_locals
    { classes_name: 'spaces', model: @space, locals: { space: @space } }
  end

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:description, :software, :token, :restaurant_key, user_ids: [])
  end
end
