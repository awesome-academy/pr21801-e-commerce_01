Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/about"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "registrations"}
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

    concern :paginatable do
      get "(page/:page)", action: :index, on: :collection, as: ""
    end

    resources :carts
    resources :orders
    resources :categories, only: :show
    resources :ratings
    resources :products, only: :show do
      resources :comments, only: [:create, :destroy]
      resource :like, module: :products
    end

    namespace :admin do
      resources :categories, concerns: :paginatable
      resources :images
      resources :products, concerns: :paginatable
      resources :users, concerns: :paginatable
    end
  end
end
