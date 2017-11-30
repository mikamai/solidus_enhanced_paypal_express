module Spree
  class Gateway::PayPalExpress < Gateway
    preference :login, :string
    preference :password, :string
    preference :signature, :string
    preference :currency_code, :string, default: 'EUR'

    def supports?(source)
      source.is_a? Spree::PaypalExpressCheckout
    end

    def provider_class
      ActiveMerchant::Billing::PaypalExpressGateway
    end

    def method_type
      'paypal_express'
    end

    def purchase(money, source, options = {})
      params = options.merge({
        token: source.token,
        payer_id: source.payer_id,
        currency: preferred_currency_code
      })
      provider.purchase(money, params)
    end

    def purchase_link(order, options)
      total_cents = order.display_total.cents
      options.merge!({
        max_amount: total_cents,
        allow_guest_checkout: true,
        currency: preferred_currency_code
      })
      response = provider.setup_purchase total_cents, options
      token = response.params['token']
      provider.redirect_url_for(token)
    end
  end
end
