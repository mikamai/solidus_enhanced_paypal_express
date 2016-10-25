class AddDestinationUrlDeToTaxonBanner < ActiveRecord::Migration
  def change
    add_column :taxon_banners, :destination_url_de, :string
  end
end
