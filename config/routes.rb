Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  root to: 'profiles#show'

  resources :accounts do
    resources :roles
  end


end
