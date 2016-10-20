class CreateTaxonBanner < ActiveRecord::Migration
  def change
    create_table :taxon_banners do |t|
      t.string :name
      t.boolean :enabled, :default => false
      t.string :destination_url
      t.attachment :desktop_size
      t.attachment :tablet_size
      t.attachment :mobile_size

      t.timestamps
    end
  end
end
