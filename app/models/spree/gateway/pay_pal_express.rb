require 'paypal-sdk-merchant'
require 'uri'

module Spree
  class Gateway::PayPalExpress < Gateway
    preference :login, :string
    preference :password, :string
    preference :signature, :string
    preference :server, :string, default: 'sandbox'
    preference :solution, :string, default: 'Mark'
    preference :landing_page, :string, default: 'Billing'
    preference :logourl, :string, default: ''
    preference :auto_capture, :boolean, default: true

    def supports?(source)
      source.is_a? PaypalExpressCheckout
    end

    def provider_class
      ActiveMerchant::Billing::PaypalExpressGateway
    end

    def method_type
      'paypal_express'
    end

    def url_domain
      sandbox? ? 'sandbox.' : ''
    end

    def purchase_link(order, options)
      total_cents = order.display_total.cents.to_f
      options.merge!(
        max_amount: total_cents,
        allow_guest_checkout: true
      )
      response = provider.setup_purchase total_cents, options
      token = response.params['token']
      provider.redirect_url_for(token)
    end


    def purchase(money, source, options = {})
      params = options.merge(token: source.token,
                             payer_id: source.payer_id)
      provider.purchase(money, params)
    end

    def sandbox?
      preferred_server == 'sandbox'
    end
  end
end
