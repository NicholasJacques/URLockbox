Rails.application.routes.draw do
  root to: 'links#index'

  resources :links, only: [:index, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update, :create]
    end
  end
end
