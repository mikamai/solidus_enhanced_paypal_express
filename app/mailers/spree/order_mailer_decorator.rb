Spree::OrderMailer.class_eval do

  def confirm_email(order, resend = false)
    @order = find_order(order)
    subject = build_subject(Spree.t('order_mailer.confirm_email.subject'), false)

    mail(to: "giulia.valente@cayenne.it, luca.mattiazzi@cayenne.it", from: "#{@order.email}", subject: subject)
  end

end
