Rails.application.routes.draw do
  root "pages#home"
  
  resources :user_logs
  resources :api_tokens, only: [:index, :create, :update]

  get 'pages/home'
  get 'pages/api', as: :api

  get 'old_plannings', to: 'plannings#old_plannings', as: :old_plannings

  resources :reservations, only: [:create, :destroy]
  resources :plannings, only: [:index, :show] do
    resources :shifts, only: [:show]
  end
  resources :users, only: [:new, :create, :show]

  get 'achievements' => 'users#achievements', :as => :achievements
  get 'videos' => 'videos#index', :as => :videos
  put '/videos/:id/complete', to: 'videos#complete', as: 'complete_video'
  get 'videos/:id' => 'videos#show', :as => :video

  get 'profil' => 'users#show', :as => :profil

  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout

  get 'users/activate/:id', to: 'users#activate', as: :activate_user

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :plannings, only: [:index] do
          resources :shifts, only: [:index] do
            resources :reservations, only: [:create, :destroy]
          end
          resources :reservations, only: [:index]
        end
      end
    end
  end
end
