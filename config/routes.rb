Rails.application.routes.draw do
  #require 'sidekiq/web'
  #require 'sidekiq-scheduler/web'

  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  #mount Sidekiq::Web => '/sidekiq'
  #devise_for :users
  root 'check_email#index'

  get '/bittrex', to: 'platforms#bittrex'

  resources :check_email

  post '/contact', to: 'contacts#create'

end
