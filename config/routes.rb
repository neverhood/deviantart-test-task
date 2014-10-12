require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'notifiers#index'

  resources :notifiers

  # Background processing frontend
  mount Sidekiq::Web => '/sidekiq'
end
