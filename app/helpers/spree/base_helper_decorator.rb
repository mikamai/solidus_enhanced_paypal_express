Spree::BaseHelper.module_eval do
  def has_starting_from_price?(product)
    product.price_in(Spree::Config[:currency]).starting_from
  end
end
