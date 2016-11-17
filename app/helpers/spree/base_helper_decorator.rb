Spree::BaseHelper.module_eval do
  def has_starting_from_price?(product)
    product.price_in(Spree::Config[:currency]).starting_from
  end

  def sold_items_display(product)
    production_start = Time.new(2016, 10, 25, 12)
    hash = product.sold_amount(production_start).each_with_object ({count: 0, amount: 0}) do |item, result|
      result[:count]  += item.quantity
      result[:amount] += item.quantity * item.price
    end
    return "#{hash[:count]} - #{hash[:amount].to_f.round(2)}€"
  end
end
