Rails.application.routes.draw do
  resources :user_logs
  get 'pages/home'
  get 'pages/api'
  root "pages#home"

  resources :reservations
  resources :shifts
  resources :plannings
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :api do
    namespace :v1 do
      resources :plannings, only: [:index, :show] do
        resources :shifts, only: [:index, :show]
        resources :reservations, only: [:index, :create, :destroy]
      end
      resources :users, only: [:show]
    end
  end
end
