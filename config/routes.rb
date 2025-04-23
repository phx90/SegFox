Rails.application.routes.draw do
  root "pages#home"

  get "about", to: "pages#about"

  # Rota pública: apenas exibição
  resources :dogs, only: [ :index, :show ]

  # Admin: pode criar, editar, deletar
  namespace :admin do
    resources :dogs
  end
end
