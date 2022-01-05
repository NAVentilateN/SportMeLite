Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks'}

  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :coach do
    resources :accounts, only: [:index]
    resources :lessons do
      collection do
        get :upcoming
        get :history
        get :sync_all_lessons_to_calendar
        get :remove_all_lessons_from_calendar
      end
      member do
        get :sync_to_google
        get :unsync_from_google
      end
    end

    resources :coach_profiles, only: [:show, :edit, :update, :destroy], as: :profile
  end

  resources :users, only: :show do
    resources :coach_profiles, only: [:new, :create]
    resources :chats, only: [:index]
  end

  resources :notifications, only: [:index]

  resources :sports, only: [:index] do
    resources :coaches, only: [:index]
  end

  resources :coaches, only: [:show] do
    resources :reviews, only: [:index]
    resources :lessons, only: [:index]
    resources :chats, only: [:create, :show] do
      resources :messages, only: [:create]
    end
    member do
      get :list_lessons
    end
  end

  resources :lessons, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
    member do
      get :make_booking
      patch :make_booking
      get :cancel_booking
      patch :cancel_booking
    end
    collection do
      get :upcoming
      get :history
    end
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end
end
