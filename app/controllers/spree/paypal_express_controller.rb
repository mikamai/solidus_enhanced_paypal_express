module Spree
  class PaypalExpressController < Spree::StoreController
    def return
      @order = current_order || raise(ActiveRecord::RecordNotFound)
      pm = Spree::PaymentMethod.find params[:payment_method_id]
      ps = Spree::PaypalExpressCheckout.create!(token: params['token'], payer_id: params['PayerID'])
      @order.payments.create!(source: ps, amount: @order.total, payment_method: pm)
      advance_order
      if @order.complete?
        flash.notice = I18n.t('spree.order.successful')
        flash[:order_completed] = true
        session[:order_id] = nil
        redirect_to completion_route(@order)
      else
        redirect_to spree.checkout_state_path(@order.state)
      end
    end

    def cancel
      flash[:notice] = I18n.t('spree.paypal.flash.cancel')
      order = current_order || raise(ActiveRecord::RecordNotFound)
      redirect_to spree.checkout_state_path(order.state)
    end

    private

    # Advance the order to the confirm state
    def advance_order
      until @order.state == 'confirm'
        @order.next!
      end
    end
  end
end
