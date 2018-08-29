Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/about"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "registrations"}

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :carts
  resources :categories, only: :show
  resources :ratings
  resources :products, only: :show do
    resource :like, module: :products
  end

  namespace :admin do
    resources :categories, concerns: :paginatable
    resources :products, concerns: :paginatable
    resources :users, concerns: :paginatable
  end
end
