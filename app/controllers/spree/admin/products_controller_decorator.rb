Spree::Admin::ProductsController.class_eval do
  before_action :set_price_starting_from, only: [:update]

  private

  def set_price_starting_from
    if @product
      price = @product.price_in(Spree::Config[:currency])
    else product = Spree::Product.find_by(slug: params[:product][:id])
      price = Spree::Product.find_by(slug: params[:product][:slug]).price_in(Spree::Config[:currency])
    end
    price.starting_from = params[:product][:starting_from]
    price.save
  end
end
