Spree::TaxonsController.class_eval do
  before_action :load_banner, only: [:show]

  private

  def load_banner
    @banner = Spree::TaxonBanner.active.last
  end

end
