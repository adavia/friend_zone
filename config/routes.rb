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
    resources :images, only: [:show] do
      member do
        post :default
      end
    end
  end

  resources :images, only: [] do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :posts, only: [:index, :create, :edit, :update, :destroy] do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :show, :new, :create]
  end
end
