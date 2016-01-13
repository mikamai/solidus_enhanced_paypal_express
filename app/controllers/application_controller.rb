class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_locale, :need_adult_age_acceptance, :adult_age_accepted
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

  def need_adult_age_acceptance
    !adult_age_accepted
  end

  def adult_age_accepted
    cookies[Rails.configuration.x.adult_age] == 'true'
  end

  helper SpreePathsHelper
  helper Spree::BaseHelper
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Store
end
