module SpreePathsHelper
  def shop_merchandising_path(sub_category = nil)
    if sub_category
      spree.nested_taxons_path "categories/merchandising/#{sub_category.to_sym}"
    else
      spree.nested_taxons_path "categories/merchandising"
    end
  end

  def shop_beers_path
    spree.nested_taxons_path "categories/beers"
  end

  def shop_christmas_beer_path
    spree.product_path Spree::Product.find_by_slug "birra-di-natale-forst-2l"
  end

  def continue_shopping_path
    spree.products_path
  end
end
