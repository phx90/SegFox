Rails.application.routes.draw do
  # Página inicial e institucional
  root "pages#home"
  get "about", to: "pages#about"

  # Sessões (login/logout)
  get    "login",  to: "sessions#new",     as: :login
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  # Público: visualizar cães
  resources :dogs, only: [ :index, :show ]

# config/routes.rb

namespace :admin_area do
  resources :dogs, only: [ :index, :new, :create, :edit, :update, :destroy, :show ]
end


  get "breeds", to: "pages#breeds", as: :breeds
  get "/terrier_brasileiro", to: "dogs#terrier_brasileiro", as: :terrier_brasileiro
  get "pastor_da_mantiqueira", to: "dogs#pastor_da_mantiqueira", as: :pastor_da_mantiqueira
end
