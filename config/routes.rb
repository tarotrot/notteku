Rails.application.routes.draw do
  root "top#index"

  resources :users

  resource :session, only: [:create, :destroy]
end
