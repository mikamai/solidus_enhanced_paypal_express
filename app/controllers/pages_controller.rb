class PagesController < ApplicationController
  def home
    render :home
  end

  def underage
    render :underage
  end

  def yes_answer
    redirect_to home_url
  end

  def no_answer
    render :forbidden, status: :forbidden
  end
end
