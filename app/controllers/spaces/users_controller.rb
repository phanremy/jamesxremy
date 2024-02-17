# frozen_string_literal: true

module Spaces
  class UsersController < ApplicationController
    before_action :set_space, only: %i[create]
    before_action :authenticate_user!, except: %i[create]

    def create
      @space_user = SpaceUser.new(space_user_params)
      @space_user.space = @space

      if @space_user.save
        warden.set_user(@space_user.user, {}) unless user_signed_in?

        render_turbo_stream
      else
        flash.now[:error] = @space_user.errors.full_messages
        render_flash
      end
    end

    private

    def set_space
      @space = Space.find(params[:space_id])
    end

    def render_turbo_stream
      user = @space_user.user
      partial = @space.confirmed_member?(user) ? 'spaces/users/success' : 'spaces/users/unconfirmed'
      render turbo_stream: turbo_stream.update(:space_users, partial:)
    end

    def space_user_params
      params.require(:space_user).permit(user_params)
    end

    def user_params
      # params[:space_user][:user_id].present?
      return [:user_id] if user_signed_in?

      [user_attributes: %i[email password password_confirmation]]
    end
  end
end
