# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.accessible_by(current_ability).order(created_at: :desc)
                 .email_query(params[:search])
                 .by_admin(params[:admin])
                 .by_confirmed(params[:confirmed])
  end

  def edit; end

  def update
    @user = User.find(params[:id])
    @user.skip_password_validation = true if params[:user][:password].blank?
    if @user.update(user_params)
      flash[:success] = I18n.t('users.update_success')
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages
      render_flash
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user != current_user && @user.destroy
      flash[:success] = I18n.t('users.destroy_success')
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages.presence || I18n.t('users.destroy_not_yourself')
      render_flash
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :confirmed)
  end
end
