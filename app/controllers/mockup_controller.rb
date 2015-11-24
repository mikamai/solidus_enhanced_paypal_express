class MockupController < PagesController
  def static
    render action: params[:page]
  end
end
