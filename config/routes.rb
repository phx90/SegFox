Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  get "up", to: proc { [ 200, { "Content-Type" => "text/plain" }, [ "OK" ] ] }

  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  resources :dogs, only: [ :index, :show ]

  namespace :admin_area do
    resources :dogs, except: :show
  end

  get "breeds", to: "pages#breeds", as: :breeds
  get "terrier_brasileiro", to: "dogs#terrier_brasileiro", as: :terrier_brasileiro
  get "pastor_da_mantiqueira", to: "dogs#pastor_da_mantiqueira", as: :pastor_da_mantiqueira
end
