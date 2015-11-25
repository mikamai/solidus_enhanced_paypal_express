module ApplicationHelper
  def taxon_splash_image_path(taxon)
    splash = case taxon.name
             when "Beers"         then 'catalog_beer/catalog_beer_splash.jpg'
             when "Merchandising" then 'merchandising/merchandising.jpg'
             when "Clothing"      then 'merchandising/merchandising.jpg'
             when "Accessories"   then 'merchandising/merchandising.jpg'
             when "Glasses"       then 'merchandising/merchandising.jpg'
             end
    image_path splash
  end
end
