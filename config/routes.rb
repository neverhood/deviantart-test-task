Rails.application.routes.draw do
  root to: 'notifiers#index'

  resources :notifiers
end
