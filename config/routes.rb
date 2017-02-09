Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  localized do
    root to: 'pages#home', as: :root
    get  'home',              to: 'pages#home',             as: 'home'
    get  'underage',          to: 'pages#underage',         as: 'underage'
    get  'yes-answer',        to: 'pages#yes_answer',       as: 'yes_answer'
    get  'no-answer',         to: 'pages#no_answer',        as: 'no_answer'
    get  'static-page',       to: 'pages#static-page'
    get  'privacy',           to: 'pages#privacy',          as: 'privacy'
    get  'sales_conditions',  to: 'pages#sales_conditions', as: 'sales_conditions'
    get  'contacts',          to: 'pages#contacts',         as: 'contacts'
  end

  get 'state_from_country', to: 'form#state_from_country'

  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.routes.append do
    namespace :admin do
      resources :taxon_banner
      resources :orders
    end
  end

  if !Rails.env.production?
    get 'mailer(/:action)' => 'spree_order_mailer#:action'
  end

end
