Rails.application.routes.draw do
  root "pages#home"
  
  resources :api_tokens, only: [:index, :create, :update]

  get 'pages/home'
  get 'pages/api', as: :api

  get 'old_plannings', to: 'plannings#old_plannings', as: :old_plannings

  resources :reservations, only: [:create, :destroy]
  resources :plannings, only: [:index, :show] do
    resources :shifts, only: [:show]
  end
  resources :users, only: [:new, :create, :show] do
  end

  get 'forgot_password', to: 'passwords#forgot_password', as: :forgot_password
  post 'send_password_reset_instructions', to: 'passwords#send_password_reset_instructions', as: :send_password_reset_instructions
  get 'reset_password', to: 'passwords#reset_password', as: :reset_password
  patch 'update_password', to: 'passwords#update_password', as: :update_password

  get 'onboarding', to: 'onboarding#onboarding', as: :onboarding
  put 'onboard', to: 'onboarding#onboard', as: :onboard
  put 'unboard', to: 'onboarding#unboard', as: :unboard

  get 'videos' => 'videos#index', :as => :videos
  put '/videos/:id/seen', to: 'videos#seen', as: 'video_seen'
  put '/videos/:id/unseen', to: 'videos#unseen', as: 'video_unseen'
  get 'ultimate_advice' => 'videos#ultimate_advice', :as => :ultimate_advice

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
