Spree::Calculator::Shipping::SimpleWeight.class_eval do

  def compute_package(package)
    content_items = package.contents
    line_items_total = total(content_items)
    handling_fee = preferred_handling_max > line_items_total ? preferred_handling_fee : 0

    total_weight = total_weight(content_items)
    costs = costs_string_to_hash(clean_costs_string)
    weight_class = costs.keys.select { |w| total_weight <= w }.min
    additional_costs = extra_price(content_items)
    shipping_costs = costs[weight_class] + additional_costs

    shipping_costs ? shipping_costs + handling_fee : 0
  end

  def available?(package)
    return false if !costs_string_valid?
    if order_overweight?(package.contents)
      package.order.errors.add(:base, Spree.t(:items_cannot_be_shipped_because_of_weight))
      return false
    end

    if preferred_max_item_size > 0
      package.contents.each do |item|
        return false if item_oversized?(item)
      end
    end

    true
  end

  private

  def extra_price(content_items)
    content_items.inject(0){ |result, item| result += item.variant.product[:packaging_cost]}
  end

end
