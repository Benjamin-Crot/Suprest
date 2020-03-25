Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  root to: 'profiles#show'

  resources :accounts do
    resources :roles
    resources :products, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        get 'my_products'
      end
    end
  end

  resources :products, only: [:index, :show]

  resources :pricings


end
