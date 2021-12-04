Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: :show do
    resources :coach_profiles, only: [:show, :new, :create, :edit, :update]
  end

  namespace :coach do
    resources :lessons do
      collection do
        get :upcoming
        get :past
      end
    end
  end

  resources :sports, only: [:index] do
    resources :coaches, only: [:index]
  end

  resources :coaches, only: [:show] do
    resources :lessons, only: [:index]
    member do
      get :list_lessons
    end
  end

  resources :lessons, only: [:index] do
    member do
      get :make_booking
      patch :make_booking
      get :cancel_booking
      patch :cancel_booking
    end
  end
end
