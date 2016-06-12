Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"

  devise_for :users

  resources :posts, only: [:index, :create, :edit, :update, :destroy] do
    resource :like, only: [:create, :destroy]
    resources :images, only: [:show]
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
