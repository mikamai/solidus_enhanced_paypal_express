Spree::TaxonsController.class_eval do
  before_action :load_banner, only: [:show]

  def show
    @taxon = Spree::Taxon.find_by_permalink!(params[:id])
    return unless @taxon
    banner = Spree::TaxonBanner.active.last
    locale = params[:locale].nil? ? "" : "_#{params[:locale]}"
    if banner && (banner.send :"desktop_size#{locale}") && (banner.send :"tablet_size#{locale}") && (banner.send :"mobile_size#{locale}")
      @banner_img = {
        url: banner.destination_url || "http://google.com",
        desktop_url: (banner.send :"desktop_size#{locale}").url,
        tablet_url: (banner.send :"tablet_size#{locale}").url,
        mobile_url: (banner.send :"mobile_size#{locale}").url,
      }
    end
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = @taxon.products.where(active: true)
  end

  private

  def load_banner
  end

end
