Rails.application.routes.draw do
  root 'pages#main'

  resources :people, only: [:index, :new, :create, :show]
  resources :books, only: [] do
    get 'search', on: :collection
  end

  get 'search/:query', to: 'books#search_result'
end
