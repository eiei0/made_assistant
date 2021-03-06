# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  resources :dashboard, only: [:index]
  resources :businesses do
    collection do
      put "import"
    end
  end
  resources :business_calendars, only: [:index]
  resources :mailers, only: %i[create destroy], param: :business_id
  resources :emails, only: %i[index show]
  get "reports/cog"
  get "reports/mailers_sent"
  resources :settings, only: [:index]

  authenticate :user do
    root to: "dashboard#index", as: :authenticated_root
    mount Sidekiq::Web, at: "/sidekiq"
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end
end
