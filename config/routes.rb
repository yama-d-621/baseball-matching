Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update] do
    member do
      get :app_offers
    end
  end
  
  resources :offers, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :app_users
    end
  end
  resources :applications, only: [:create]
end
