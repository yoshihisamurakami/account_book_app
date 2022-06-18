Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  get 'user/:id/books', to: 'user_books#index', as: 'user_books'

  resources :accounts do
    get 'books', on: :member
  end
  resources :categories
  resources :books,    only: [:create, :index, :edit, :update, :destroy]
  resources :budgets,  only: [:new, :create, :index, :edit, :update, :destroy]

  get '/target_months/prev', to: 'target_months#prev', as: :prev_month
  get '/target_months/next', to: 'target_months#next', as: :next_month
  get '/reports/categories', to: 'reports#categories', as: :report_categories
  get '/reports/deposit_payment', to: 'reports#deposit_payment', as: :report_deposit_payment
  get '/reports/deposit', to: 'reports#deposit', as: :report_deposit
  get '/reports/tax', to: 'reports#tax', as: :report_tax
  get '/reports/special', to: 'reports#special', as: :report_special
  get '/reports/business', to: 'reports#business', as: :report_business
  get '/monthly_report',     to: 'monthly_reports#index'
  get '/books/tsv', to: 'books#tsv'
end
