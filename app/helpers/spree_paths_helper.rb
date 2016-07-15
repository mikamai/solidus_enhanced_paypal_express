module SpreePathsHelper
  def shop_merchandising_path(sub_category = nil)
    taxon = if sub_category
      Spree::Taxon.find_by_name(Spree.t("categories.#{sub_category}"))
    else
      Spree::Taxon.find_by_name(Spree.t('categories.merchandising'))
    end
    spree.nested_taxons_path(taxon)
  end

  def shop_beers_path
    taxon = Spree::Taxon.find_by_name(Spree.t('categories.beers'))
    spree.nested_taxons_path(taxon)
  end

  def shop_christmas_beer_path
    christmas_beer = Spree::Product.find_by_id 4
    spree.product_path(christmas_beer) if christmas_beer
  end

  def continue_shopping_path
    root_path
  end

  def locale_path
    "/#{I18n.locale.to_s}"
  end
end
