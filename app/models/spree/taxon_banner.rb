class Spree::TaxonBanner < ActiveRecord::Base

  scope :active, -> { where(enabled: true) }

  self.table_name = "taxon_banners"

  has_attached_file :desktop_size, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :desktop_size, content_type: /\Aimage\/.*\z/
  has_attached_file :tablet_size, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :tablet_size, content_type: /\Aimage\/.*\z/
  has_attached_file :mobile_size, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :mobile_size, content_type: /\Aimage\/.*\z/
end
