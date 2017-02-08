Spree::OrderMailer.class_eval do

  def confirm_email(order, resend = false)
    @order = find_order(order)
    subject = build_subject(Spree.t('order_mailer.confirm_email.subject'), false)

    mail(to: "shop@forst.it", from: "#{@order.email}", subject: subject)
  end

  def order_completed_email(order, resend = false)
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
    @order = find_order(order)
    subject = build_subject(Spree.t('order_mailer.confirm_email.subject'), false)

    mail(to: "shop@forst.it", from: "#{@order.email}", subject: subject)
  end

end
