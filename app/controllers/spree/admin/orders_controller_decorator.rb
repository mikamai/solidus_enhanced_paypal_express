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

end
