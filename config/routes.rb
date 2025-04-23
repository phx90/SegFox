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

  # Admin: gerenciar cães
  namespace :admin do
    resources :dogs
  end
end
