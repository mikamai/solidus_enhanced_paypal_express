Spree::CheckoutController.class_eval do
  after_action :confirm_email, only: [:update]

  private

  def confirm_email
    if @order.completed?
      begin
        Spree::OrderMailer.confirm_email(@order).deliver
      rescue
        Logger.new("#{Rails.root}/log/mailer_error.log").info("Couldn't send confirmation email for order ##{@order.number}")
      end
    end
  end
end
