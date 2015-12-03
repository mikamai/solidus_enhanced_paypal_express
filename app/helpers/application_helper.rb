module ApplicationHelper
  def taxon_splash_image_path(taxon)
    taxon_name = Globalize.with_locale(:en) { taxon.name }
    splash = case taxon_name
             when "Beers"         then 'catalog_beer/catalog_beer_splash.jpg'
             when "Merchandising" then 'merchandising/merchandising.jpg'
             when "Clothing"      then 'merchandising/merchandising.jpg'
             when "Accessories"   then 'merchandising/merchandising.jpg'
             when "Glasses"       then 'merchandising/merchandising.jpg'
             end
    image_path splash
  end
end
