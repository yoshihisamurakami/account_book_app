Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :accounts, only: [:new, :create, :index, :edit, :update]
  resources :categories
  resources :books,    only: [:create, :index, :edit, :update, :destroy]
  get '/target_terms/prev', to: 'target_terms#prev'
  get '/target_terms/next', to: 'target_terms#next'
end
