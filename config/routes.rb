require 'sidekiq/web'

Rails.application.routes.draw do
  # meter ####
  draw(:meter)

  ############
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'
  mount PgHero::Engine, at: 'pghero'
  resources :posts

  resources :quotes
  resources :photos
  resources :subscriptions
  resources :comments
  draw(:admin)
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root "events#index"

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]

    post :show, on: :member
  end

  resources :users, only: [:show, :edit, :update]

  %w(404 422 500).each do |code|
    get code, to: 'errors#show', code: code
  end
end
