Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, except: :index

  namespace :coach do
    resources :lessons
  end

  resources :sports, only: [:index] do
    resources :coaches, only: [:index]
  end

  resources :coaches, only: [:show] do
    resources :lessons, only: [:index]
  end

  resources :lessons, only: [:index]

  resources :user do
    resources :coach_profile, only: [:show, :new, :create, :edit, :update]
  end
end
