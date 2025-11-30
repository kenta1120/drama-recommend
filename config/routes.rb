Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in', as: :guest_user_sign_in
  end

  root to: "home#index"
  get "recommend", to: "home#recommend"

  resources :users, only: [:show, :edit, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :dramas
  resource :home, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
