Spree::Order.class_eval do
  def deliver_order_confirmation_email
    # OrderMailer.confirm_email(self).deliver_later
    update_column(:confirmation_delivered, true)
  end
end
