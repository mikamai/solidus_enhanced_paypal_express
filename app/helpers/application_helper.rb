module ApplicationHelper
  def taxon_splash_image_path(taxon)
    taxon_name = Globalize.with_locale(:en) { taxon.name }
    splash = case taxon_name.downcase
             when "beers"         then 'catalog_beer/catalog_beer_splash.jpg'
             when "merchandising" then 'merchandising/merchandising.jpg'
             when "clothing"      then 'merchandising/merchandising.jpg'
             when "accessories"   then 'merchandising/merchandising.jpg'
             when "glasses"       then 'merchandising/merchandising.jpg'
             end
    image_path splash
  end

  def patched_route_path(route)
    begin
      send "#{route}_path"
    rescue NameError
      Rails.application.routes.url_helpers.send "#{route}_#{I18n.locale}_path"
    end
  end
end
