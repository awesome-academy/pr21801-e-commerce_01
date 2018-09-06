Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/about"

  get "/products/:product_id/comments/new/(:parent_id)", to: "comments#new",
    as: :new_comment

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "registrations"}

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
