Spree::Product.class_eval do
  attr_accessor :starting_from

  after_create :set_price_as_starting_from

  def sold_amount(from = Time.new(1988, 8, 1), to = Time.now)
    variants_ids = self.variants_including_master.pluck(:id)
    items_sold = Spree::LineItem.where(variant_id: variants_ids)
                                .joins(:order)
                                .where("spree_orders.state = ?", "complete")
                                .where("spree_orders.completed_at >= ?", from)
                                .where("spree_orders.completed_at <= ?", to)
  end

  private

  def set_price_as_starting_from
    return unless starting_from

    product_price = price_in(Spree::Config[:currency])
    product_price.starting_from = true
    product_price.save
  end
end
