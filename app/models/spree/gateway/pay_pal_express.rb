require 'paypal-sdk-merchant'
require 'uri'

module Spree
  class Gateway::PayPalExpress < Gateway
    preference :use_new_layout, :boolean, default: true
    preference :login, :string
    preference :password, :string
    preference :signature, :string
    preference :server, :string, default: 'sandbox'
    preference :solution, :string, default: 'Mark'
    preference :landing_page, :string, default: 'Billing'
    preference :logourl, :string, default: ''
    preference :auto_capture, :boolean, default: true

    def supports?(source)
      source.is_a? PaypalExpressSource
    end

    def provider_class
      ActiveMerchant::Billing::PaypalExpressGateway
    end

    def method_type
      'paypal_express'
    end

    # amount :: float
    # express_checkout :: Spree::PaypalExpressCheckout
    # gateway_options :: hash
    def authorize(amount, express_checkout, gateway_options={})
      response =
        do_authorize(express_checkout.token, express_checkout.payer_id)

      # TODO: don't do this, use authorization instead
      # this is a hold over from old code.
      # I don't think this actually even used by anything?
      express_checkout.update transaction_id: response.authorization

      response
    end

    # https://developer.paypal.com/docs/classic/api/merchant/DoCapture_API_Operation_NVP/
    # for more information
    def capture(amount_cents, authorization, currency:, **_options)
      do_capture(amount_cents, authorization, currency)
    end

    def server_domain
      preferred_server == 'live' ? '' : 'sandbox.'
    end

    def express_checkout_url(pp_response, extra_params = {})
      params = {
        token: pp_response.Token
      }.merge(extra_params)

      if preferred_use_new_layout
        layout = 'checkoutnow/2?'
      else
        layout = 'cgi-bin/webscr?cmd=_express-checkout&force_sa=true&'
      end

      "https://www.#{server_domain}paypal.com/#{layout}#{URI.encode_www_form(params)}"
    end

    def purchase_link(order, options)
      total_cents = order.display_total.cents
      options.merge!({
        currency: order.currency,
        max_amount: total_cents,
        allow_guest_checkout: true
      })
      response = provider.setup_purchase total_cents, options
      token = response.params['token']
      provider.redirect_url_for(token)
    end

    def do_authorize(token, payer_id)
      response =
        provider
        .do_express_checkout_payment(
          checkout_payment_params(token, payer_id)
        )

      build_response(response, authorization_transaction_id(response))
    end

    def do_capture(amount_cents, authorization, currency)
      response = provider
                 .do_capture(
                   provider.build_do_capture(
                     amount: amount_cents / 100.0,
                     authorization_id: authorization,
                     completetype: 'Complete',
                     currencycode: options[:currency]
                   )
                 )

      build_response(response, capture_transaction_id(response))
    end

    def capture_transaction_id(response)
      response.do_capture_response_details.payment_info.transaction_id
    end

    def build_response(response, transaction_id)
      ActiveMerchant::Billing::Response.new(
        response.success?,
        JSON.pretty_generate(response.to_hash),
        response.to_hash,
        authorization: transaction_id,
        test: sandbox?
      )
    end

    def payment_details(token)
      provider
        .get_express_checkout_details(
          checkout_details_params(token)
        )
        .get_express_checkout_details_response_details
        .payment_details
    end

    def purchase(money, source, options = {})
      params = options.merge(token: source.token,
                             payer_id: source.payer_id)
      provider.purchase(money, params)
    end

    def checkout_payment_params(token, payer_id)
      provider
        .build_do_express_checkout_payment(
          build_checkout_payment_params(
            token,
            payer_id,
            payment_details(token)
          )
        )
    end

    def checkout_details_params(token)
      provider
        .build_get_express_checkout_details(Token: token)
    end

    def build_checkout_payment_params(token, payer_id, payment_details)
      {
        DoExpressCheckoutPaymentRequestDetails: {
          PaymentAction: 'Authorization',
          Token: token,
          PayerID: payer_id,
          PaymentDetails: payment_details
        }
      }
    end

    def sandbox?
      preferred_server == 'sandbox'
    end
  end
end
