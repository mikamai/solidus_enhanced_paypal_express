class SpreeOrderMailerController < ApplicationController
  layout "mailer"

  def confirm_email
    @host = case Rails.env
    when "development"
      "localhost:3000"
    when "staging"
      "http://forst-shop.cayennelabs.it"
    when "production"
      "https://shop.forst.it"
    else
      ""
    end
    @order = Spree::Order.where(state: "complete").limit(1).order("RAND()")[0]
    render file: "spree/order_mailer/confirm_email.html.erb"
  end

end
