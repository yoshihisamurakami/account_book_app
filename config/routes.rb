Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :accounts do
    get 'books', on: :member
  end

  resources :categories
  resources :books,    only: [:create, :index, :edit, :update, :destroy]
  get '/target_terms/prev', to: 'target_terms#prev', as: :prev_month
  get '/target_terms/next', to: 'target_terms#next', as: :next_month
end
