class MockupController < ApplicationController
  def static
    render action: params[:page]
  end
end
