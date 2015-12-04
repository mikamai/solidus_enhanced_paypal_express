Rails.application.routes.draw do
  get '/(:locale)', locale: /it|en|de/, to: 'pages#underage', as: :root

  get  'home', to: 'pages#home'
  get  'yes-answer', to: 'pages#yes_answer'
  get  'no-answer', to: 'pages#no_answer'
  get 'mockup/:page', to: 'mockup#static'
  mount Spree::Core::Engine, at: '/'
end
