Rails.application.routes.draw do
  get 'calendars/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "/up", to: "rails/health#show"

  # Defines the root path route ("/")
  # root "posts#index"
  root "main#index"

  if ENV["ENABLE_LETTER_OPENER_WEB"] == "true"
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :users, only: [:new, :create]
  resources :password_resets, only: %i[new create edit update]
  resources :calendars, only: [:index]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :questions, only: [:show] do
    member do
      get 'explanation'
    end
  end

  resources :quizzes, only: [:show] do
    member do
      get 'explanation'
    end
  end

  get 'questions', to: 'questions#show'
  get 'quizzes', to: 'quizzes#show'
  get 'settings', to: 'settings#index'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'main', to: 'main#index'
  get 'settings/level', to: 'settings#level', as: 'settings_level'
  get 'settings/notification', to: 'settings#notification', as: 'settings_notification'
  get 'settings/account', to: 'settings#account', as: 'settings_account'

  namespace :admin do
    root to: "main#index"
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :questions
  end
end
