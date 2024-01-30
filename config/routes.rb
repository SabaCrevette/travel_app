Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  root 'tops#index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get '/mypage', to: 'users#index', as: 'mypage'
  get '/mypage/:user_id', to: 'users#show'
  get '/search', to: 'posts#index', as: 'search'
  get 'prefectures/:id/areas', to: 'prefectures#areas'
  get 'terms_of_service', to: 'tops#terms_of_service'
  get 'privacy_policy', to: 'tops#privacy_policy'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" 
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider  
  
  resources :release_notes
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  resources :posts, except: :index do
    get 'toggle_partial', on: :collection
    collection do
      get 'bookmarks'
      get 'autocomplete_location'
      get 'autocomplete_text'
      get 'autocomplete_tag_name'
    end
  end

  resource :profile, only: %i[show edit update]

  resources :bookmarks, only: %i[create destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'up' => 'rails/health#show', as: :rails_health_check

end
