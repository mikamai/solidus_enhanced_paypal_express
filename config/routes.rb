Spree::Core::Engine.routes.draw do
  get 'paypal_return', to: 'paypal_express#return', as: :paypal_return
  get 'paypal_cancel', to: 'paypal_express#cancel', as: :paypal_cancel

  namespace :admin do
    # Using :only here so it doesn't redraw those routes
    resources :orders, only: [] do
      resources :payments, only: [] do
        member do
          get 'paypal_refund'
          post 'paypal_refund'
        end
      end
    end
  end
end
