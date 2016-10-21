Spree::TaxonsController.class_eval do
  before_action :load_banner, only: [:show]


  def show
    @taxon = Spree::Taxon.find_by_permalink!(params[:id])
    return unless @taxon
    @banner = Spree::TaxonBanner.active.last
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = @taxon.products.where(active: true)
  end


  private

  def load_banner
  end

end
