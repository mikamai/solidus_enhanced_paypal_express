Spree::Gateway::PayPalExpress.class_eval do
  def do_capture(amount_cents, authorization, currency)
    captured_payment = provider.build_do_capture(
      amount: {
          currencyID: currency,
          value: amount_cents / 100.0 },
        authorization_id: authorization,
        completetype: "Complete",
        currencycode: currency
    )

    response = provider.
      do_capture(
        captured_payment)

    build_response(response, capture_transaction_id(response))
  end
end
