module TaxonBannerHelper

  def render_big_banner(banner)
    image = image_tag banner["desktop_size"].url, :class => "visible-md visible-lg"
    link_to image, banner.destination_url
  end

end
