module SpreePathsHelper
  def shop_merchandising_path(sub_category = nil)
    if sub_category
      locale_path + spree.nested_taxons_path("categories/merchandising/#{sub_category.to_sym}")
    else
      locale_path + spree.nested_taxons_path("categories/merchandising")
    end
  end

  def shop_beers_path
    locale_path + spree.nested_taxons_path("categories/beers")
  end

  def shop_christmas_beer_path
    christmas_beer = Spree::Product.find_by_id 4
    locale_path + spree.product_path(christmas_beer) if christmas_beer
  end

  def continue_shopping_path
    locale_path + spree.products_path
  end

  def locale_path
    "/#{I18n.locale.to_s}"
  end
end
