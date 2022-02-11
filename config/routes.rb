Rails.application.routes.draw do
  root 'pages#main'

  resources :people, only: [:index, :new, :create, :show]
  resources :books, only: [:search]
end
