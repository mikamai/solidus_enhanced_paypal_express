Rails.application.routes.draw do
  root to: 'pages#home'
  get 'mockup/:page', to: 'mockup#static'
  mount Spree::Core::Engine, at: '/'
end
