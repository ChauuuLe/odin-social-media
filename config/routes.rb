Rails.application.routes.draw do
  
  root to: "homes#index"
  devise_for :users

  resources :posts, only: [:index, :create, :destroy, :show, :new] do
    member do
      post 'like', to: 'likes#create'
      delete 'unlike', to: 'likes#destroy'
    end
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show] do
  	resources :friend_requests, only: [:create, :index, :destroy]
  	resources :friends, only: [:create, :index]
  end

  #resources :friend_requests, only: [:destroy]
  resources :friends, only: [:destroy]

  resources :posts, only: [:index, :create, :destroy, :show]
  
end

