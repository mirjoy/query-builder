Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: [:new, :create]
end
