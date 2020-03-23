Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :dashboards, only: [:create, :show]
  root to: 'dashboards#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants do
  end


end
