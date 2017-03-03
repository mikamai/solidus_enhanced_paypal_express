Spree::OrdersController.class_eval do

  before_action :dummy_validate_first_state_order, only: :update
  after_action :send_confirm_email, only: :update

  def update
    if @order.contents.update_cart(order_params)
      respond_with(@order) do |format|
        format.html do
          if params.key?(:checkout)
            @order.next if @order.cart?
            redirect_to checkout_state_path(@order.checkout_steps.first)
          else
            redirect_to cart_path
          end
        end
      end
    else
      respond_with(@order)
    end
  end

  def dummy_validate_first_state_order
    if(@order.state == "address" && @order.ship_address && !@order.ship_address.valid? && @order.ship_address && !@order.bill_address.valid?)
      @order.update_attribute(:state, "cart")
      @order.ship_address.delete
      @order.bill_address.delete
    end
  end

  def send_confirm_email
    if @order.completed?
      Spree::OrderMailer.confirm_email(@order).deliver_later
    end
  end

end
