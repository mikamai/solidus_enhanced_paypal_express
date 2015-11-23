Rails.application.routes.draw do
  root to: 'pages#home'
  get 'mockup/:page', controller: :mockup, action: :static
  mount Spree::Core::Engine, at: '/'
end
