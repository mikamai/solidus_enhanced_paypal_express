Spree::ProductsController.class_eval do

  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_from_404

  private

  def load_product
    if try_spree_current_user.try(:has_spree_role?, "admin")
      @products = Spree::Product.with_deleted
    else
      @products = Spree::Product.active(current_currency).where(active: true)
    end
    @product = @products.friendly.find(params[:id])
  end

  def rescue_from_404
    if params["action"] == "show"
      redirect_to action: "index"
    else
      render_404
    end
  end

end
