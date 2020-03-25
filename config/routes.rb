Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :dashboards, only: [:create, :show] do
    collection do
      get 'welcome'
      get 'configuration'
    end
  end

  root to: 'dashboards#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants do
  end

  resources :suppliers do
    resources :products
  end


  resources :accounts do
    resources :roles
  end


end
