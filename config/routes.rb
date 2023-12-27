# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  root 'tops#index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get '/mypage', to: 'users#index'
  get '/mypage/:user_id', to: 'users#show'
  get '/search', to: 'posts#index'
  
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  resources :posts, except: :index # 通常のCRUDルートを生成し、indexを除外

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
