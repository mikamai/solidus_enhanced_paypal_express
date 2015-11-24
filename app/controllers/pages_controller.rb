class PagesController < ApplicationController
  helper_method :shop_merchandising_path
  helper_method :shop_beers_path
  helper_method :shop_christmas_beer_path

  def home
    render :home
  end

  def merchandising
    parent_taxon = Spree::Taxon.find_by_name!("Merchandising")
    render :merchandising, locals: {
      taxons: Spree::Taxon.where(parent: parent_taxon),
    }
  end

  private

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

end
