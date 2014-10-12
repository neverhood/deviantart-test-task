require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'notifiers#index'

  resources :notifiers, except: [ :edit, :update ] do
    post :start, :on => :member
    post :stop,  :on => :member
  end

  get '/streams/watcher_updates' => 'streams#watcher_updates'

  # Background processing frontend
  mount Sidekiq::Web => '/sidekiq'
end
