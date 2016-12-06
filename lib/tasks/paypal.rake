namespace :paypal do

  desc "Captures all payments"
  task "capture_all_payments" => :environment do
    log = Logger.new(Rails.root.join("log","paypal_capture.log"))
    payments = Spree::Payment.where(payment_method_id: 11).where(state: "pending")
    log.info("Capturing #{payments.size} payments!")
    payments.each do |payment|
      begin
        log.info("Capturing payment ##{payment[:id]} for order ##{payment[:order_id]}...")
        payment.capture!
      rescue
        log.info("Could not capture!")
      end
    end
  end

end
