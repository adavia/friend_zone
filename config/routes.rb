Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"

  devise_for :users, controllers: { registrations: :registrations }

  resources :users, only: [:show] do
    member do
      post :follow
    end
    member do
      post :unfollow
    end
  end

  resources :posts, only: [:index, :create, :edit, :update, :destroy] do
    resource :like, only: [:create, :destroy]
    resources :images, only: [:show]
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
