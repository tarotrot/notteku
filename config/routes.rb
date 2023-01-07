Rails.application.routes.draw do
  root "top#index"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  resource :session, only: [:create, :destroy]
  resource :account, except: [:index]
  resource :password, only: [:show, :edit, :update]
  resources :bookings

  namespace :admin do
    root "top#index"
    resources :users, except: [:new, :create]
    resources :pricelists, except: [:show]
    resources :stores
    resources :cars
    resources :bookings, except: [:new, :create, :destroy]
  end
end
