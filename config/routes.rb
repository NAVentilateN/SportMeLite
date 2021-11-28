Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # for List of User Lessons page (Coach's journey with toggle button)
  namespace :coach do
    resources :lessons
  end

  # for Find Sport page > Find Coach page
  resources :sports, only: [:index] do
    resources :coaches, only: [:index]
  end

  # for Coach Details page > List of Lessons page
  resources :coaches, only: [:show] do
    resources :lessons, only: [:index]
  end

  # all 7 CRUD actions required for lessons
  resources :lessons

  # for Edit Profile page
  resources :user, only: [:edit, :update]
end
