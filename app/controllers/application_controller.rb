class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_locale
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_locale
    set_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  helper SpreePathsHelper
end
