Spree::Product.class_eval do
  attr_accessor :starting_from

  after_create :set_price_as_starting_from

  private

  def set_price_as_starting_from
    return unless starting_from

    product_price = price_in(Spree::Config[:currency])
    product_price.starting_from = true
    product_price.save
  end
end
