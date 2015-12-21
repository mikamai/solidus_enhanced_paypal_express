class PagesController < ApplicationController
  include SolidusI18n::ControllerLocaleHelper

  def home
    render :home
  end

  def underage
    render :underage
  end

  def privacy
    render :privacy
  end

  def yes_answer
    redirect_to home_url
  end

  def no_answer
    render :forbidden, status: :forbidden
  end
end
