# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      respond_to do |format|
        format.json { head :forbidden }
        format.turbo_stream do
          flash.now[:alert] = 'You have to log in to continue.'
          render_flash
        end
        format.html do
          session[:next] = request.fullpath
          redirect_to new_user_session_url, alert: 'You have to log in to continue.'
        end
      end
    else
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to main_app.root_url, alert: exception.message }
      end
    end
  end

  def render_flash
    render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
  end

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params_locale || browser_locale || I18n.default_locale
  end

  def browser_locale
    request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).find do |locale|
      available_locale(locale)
    end
  end

  def params_locale
    available_locale(params[:locale])
  end

  def available_locale(locale)
    I18n.available_locales.find { |candidate| locale&.to_sym == candidate }
  end
end
