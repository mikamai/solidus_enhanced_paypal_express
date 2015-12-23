class PagesController < ApplicationController
  include SolidusI18n::ControllerLocaleHelper

  def home
    redirect_to underage_url and return if need_adult_age_acceptance
    render :home
  end

  def underage
    redirect_to home_url and return unless need_adult_age_acceptance
    render :underage
  end

  def privacy
    render :privacy
  end

  def sales_conditions
    render :sales_conditions
  end

  def contacts
    render :contacts
  end

  def yes_answer
    cookies[Rails.configuration.x.adult_age] = 'true'
    redirect_to home_url
  end

  def no_answer
    render :forbidden, status: :forbidden
  end
end
