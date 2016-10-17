class FormController < ApplicationController
  layout false

  def state_from_country
    country = Spree::Country.find_by_id(params[:id])
    if country && country.states.length > 0
      states = country.states
      response = ""
      states.each do |state|
        response += "<option value='#{state[:id]}'>#{state[:name]}</option>"
      end
      render text: response, layout: false
    else
      render text: nil
    end
  end

end
