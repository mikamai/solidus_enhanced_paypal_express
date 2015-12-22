Rails.application.routes.draw do

  localized do
    root to: 'pages#underage', as: :root
    get  'home',              to: 'pages#home',             as: 'home'
    get  'yes-answer',        to: 'pages#yes_answer',       as: 'yes_answer'
    get  'no-answer',         to: 'pages#no_answer',        as: 'no_answer'
    get  'mockup/:page',      to: 'mockup#static'
    get  'static-page',       to: 'pages#static-page'
    get  'privacy',           to: 'pages#privacy',          as: 'privacy'
    get  'sales-conditions',  to: 'pages#sales_conditions', as: 'sales_conditions'
    get  'contacts',          to: 'pages#contacts',         as: 'contacts'
  end

  mount Spree::Core::Engine, at: '/'
end
