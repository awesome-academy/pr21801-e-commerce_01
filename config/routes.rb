Rails.application.routes.draw do
  get "/users", to: "admin/users#index"

  root "static_pages#home"
  get "static_pages/about"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "registrations"}

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :categories, only: [:show]

  namespace :admin do
    resources :users, concerns: :paginatable
    resources :categories, concerns: :paginatable
  end
end
