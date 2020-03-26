Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  root to: 'profiles#show'

  resources :accounts do
    resources :roles
    resources :products, only: [:index, :new, :create, :show] do
      collection do
        get 'my_products'
      end
      resources :pricings, only: [:index]
      resources :items, only: [:index, :new, :create]
    end
    resources :orders, only: [:index, :create]
  end

  resources :products, only: [:edit, :update, :destroy] do
    resources :pricings, only: [:new, :create]
  end

  resources :pricings, only: [:edit, :update, :destroy]
  resources :orders, only: [:edit, :update, :destroy]
  resources :items, only: [:edit, :update, :destroy]
end
