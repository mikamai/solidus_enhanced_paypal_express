Spree::OrderMailer.class_eval do

  layout "mailer", only: [:confirm_email]

  def confirm_email(order, resend = false)
    @host = case Rails.env
    when "development"
      "http://localhost:3000"
    when "staging"
      "http://forst-shop.cayennelabs.it"
    when "production"
      "https://shop.forst.it"
    else
      "http://localhost:3000"
    end
    @order = find_order(order)
    subject = build_subject(Spree.t('order_mailer.confirm_email.subject'), false)

    mail(to: "#{@order.email}", bcc: "shop@forst.it", from: "shop@forst.it", subject: subject)
  end

end
