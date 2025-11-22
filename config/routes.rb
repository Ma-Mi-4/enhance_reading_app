Rails.application.routes.draw do
  get 'emails/edit'
  get 'emails/update'
  get 'passwords/edit'
  get 'passwords/update'
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

  resources :users, only: [:new, :create] do
    member do
     get 'set_level', to: 'settings#level'
      patch 'update_level', to: 'settings#update_level'
    end

    collection do
      get 'set_level', to: 'settings#level'
      patch 'update_level_for_registration', to: 'settings#update_level_for_registration'
    end
  end

  resources :password_resets, only: %i[new create edit update]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :questions, only: [:show] do
    member do
      post 'explanation'
      post 'answer'
    end
  end

  resources :quizzes, only: [:show] do
    member do
      post 'explanation'
      post 'answer'
    end
  end

  get 'questions', to: 'questions#show'
  get 'quizzes', to: 'quizzes#show'
  get 'settings', to: 'settings#index'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'main', to: 'main#index'
  get 'settings/notification', to: 'settings#notification', as: 'settings_notification'
  patch 'settings/notification', to: 'settings#update_notification', as: 'update_notification_settings'
  get 'settings/account', to: 'settings#account', as: 'settings_account'
  get '/calendars', to: 'calendars#index', as: 'calendars'
  get '/calendars/:date', to: 'calendars#show', as: 'calendar_day'
  get  'users/password/edit', to: 'passwords#edit',   as: 'edit_user_password'
  patch 'users/password',     to: 'passwords#update', as: 'user_password'
  get   'users/email/edit', to: 'emails#edit',   as: 'edit_user_email'
  patch 'users/email',      to: 'emails#update', as: 'user_email'

  namespace :admin do
    root to: "main#index"
    get 'login', to: 'sessions#new', as: 'login'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :questions
  end
end
