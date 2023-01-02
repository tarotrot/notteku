Rails.application.routes.draw do
  root "top#index"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  resources :users

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]

  namespace :admin do
    root "top#index"
    resources :users
  end
end
