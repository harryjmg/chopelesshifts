Rails.application.routes.draw do
  root "pages#home"
  
  resources :user_logs
  resources :api_tokens, only: [:index, :create, :update]

  get 'pages/home'
  get 'pages/api', as: :api
  get 'pages/instructions', as: :instructions

  resources :reservations, only: [:create, :destroy]
  resources :shifts, only: [:show]
  resources :plannings, only: [:index, :show]
  resources :users, only: [:new, :create, :show, :edit, :update]

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout

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
