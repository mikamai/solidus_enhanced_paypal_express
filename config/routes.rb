Rails.application.routes.draw do
  mount Spree::Core::Engine, :at => '/'

  get 'mockup/:page', controller: :mockup, action: :static
end
