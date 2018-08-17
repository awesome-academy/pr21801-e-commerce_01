Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/about"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  resources :categories

  namespace :admin do
    resources :users
    resources :categories
  end
end
