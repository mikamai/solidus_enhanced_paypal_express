class PagesController < ApplicationController
  def home
    render :home
  end

  def merchandising
    parent_taxon = Spree::Taxon.find_by_name!("Merchandising")
    render :merchandising, locals: {
      taxons: Spree::Taxon.where(parent: parent_taxon),
    }
  end
end
