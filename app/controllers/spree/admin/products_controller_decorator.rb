Spree::Admin::ProductsController.class_eval do
  before_action :set_price_starting_from, only: [:update]

  private

  def set_price_starting_from
    price = Spree::Product.find_by(slug: params[:product][:slug]).price_in(Spree::Config[:currency])
    price.starting_from = params[:product][:starting_from]
    price.save
  end
end
