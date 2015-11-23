class PagesController < ApplicationController
  helper_method :shop_merchandising_path
  helper_method :shop_beers_path
  helper_method :shop_christmas_beer_path

  def home
    render :home
  end

  private

  def shop_merchandising_path
    spree.nested_taxons_path "categories/merchandising"
  end

  def shop_beers_path
    spree.nested_taxons_path "categories/beers"
  end

  def shop_christmas_beer_path
    spree.product_path Spree::Product.find_by_slug "birra-di-natale-forst-2l"
  end

end
