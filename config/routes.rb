Rails.application.routes.draw do
  get '/(:locale)', locale: /it|en|de/, to: 'pages#underage', as: :root

  localized do
    get  'home', to: 'pages#home', as: 'home'
    get  'yes-answer', to: 'pages#yes_answer', as: 'yes_answer'
    get  'no-answer', to: 'pages#no_answer', as: 'no_answer'
    get  'mockup/:page', to: 'mockup#static'
    get  'static-page', to: 'pages#static-page'
  end

  mount Spree::Core::Engine, at: '/'
end
