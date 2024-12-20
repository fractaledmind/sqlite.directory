oauth_provider ||= GitHubOAuth.new

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  match "/developer/oauth/*phase", to: oauth_provider, via: :all

  # AUTHENTICATED
  resources :entries, only: %i[ new create edit update destroy ]
  resources :sessions, only: %i[ destroy ]

  # UNAUTHENTICATED
  resources :users, only: %i[ show ], param: :slug
  resources :entries, only: %i[ index show ]
  namespace :github do
    resource :authorization, only: %i[ create show ]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "entries#index"
end
