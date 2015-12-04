Rails.application.routes.draw do
  root to: 'pages#underage'

  get  'home', to: 'pages#home'
  get  'yes-answer', to: 'pages#yes_answer'
  get  'no-answer', to: 'pages#no_answer'
  get 'mockup/:page', to: 'mockup#static'
  mount Spree::Core::Engine, at: '/'
end
