Spree::Admin::OrdersController.class_eval do

  def show
    @order = Spree::Order.includes(line_items: [variant: [:option_values, :images, :product]], bill_address: :state, ship_address: :state).find_by_number!(params[:id])
    respond_to do |format|
      format.html
      # format.pdf do
      #   render pdf: "order_#{@order.number}"
      # end
    end
  end

  ## CLEANER VERSION OF SOMETHING REALLY BAD
  # def approve
  #   @order.contents.approve(user: try_spree_current_user)
  #   @order.shipments.each do |shipment|
  #     shipment.ready! if (shipment.can_transition_from_pending_to_ready? && shipment.pending?)
  #   end
  #   @order.payments.each do |payment|
  #     case
  #     when payment.response_code == nil
  #     when payment.state == "failed"
  #       transaction_id = payment.response_code
  #       real_state = Spree::PaypalExpressCheckout.find_by_transaction_id(transaction_id).state
  #       payment.update_attribute(:state, "complete") if real_state == "complete"
  #     when payment.state == "pending"
  #       payment.update_attribute(:state, "complete")
  #     end
  #   end
  #   flash[:success] = Spree.t(:order_approved)
  #   redirect_to :back
  # end

  ## THE SHITTIEST THING EVAH, I FEEL REAL BAD
  def approve
    @order.contents.approve(user: try_spree_current_user)
    @order.shipments.each do |shipment|
      shipment.ready! if (shipment.can_transition_from_pending_to_ready? && shipment.pending?)
    end
    @order.payments.each do |payment|
      payment.update_attribute(:state, "complete")
    end
    flash[:success] = Spree.t(:order_approved)
    redirect_to :back
  end
end
