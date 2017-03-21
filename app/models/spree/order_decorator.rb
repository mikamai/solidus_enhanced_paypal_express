Spree::Order.class_eval do

  def ensure_available_shipping_rates
    if shipments.empty? || shipments.any? { |shipment| shipment.shipping_rates.blank? }
      shipments.destroy_all
      if errors.empty?
        errors.add(:base, Spree.t(:items_cannot_be_shipped))
      end
      return false
    end
  end

end
