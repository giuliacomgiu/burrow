# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#main'

  resources :people, only: %i[index new create show]
  resources :books, only: [] do
    get 'search', on: :collection
    get 'search_result', on: :collection, to: 'books#search_result', as: 'search_result'
  end
end
