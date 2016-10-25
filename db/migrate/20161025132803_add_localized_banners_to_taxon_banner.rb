class AddLocalizedBannersToTaxonBanner < ActiveRecord::Migration
  def change
    add_attachment :taxon_banners, :desktop_size_de
    add_attachment :taxon_banners, :tablet_size_de
    add_attachment :taxon_banners, :mobile_size_de
  end
end
