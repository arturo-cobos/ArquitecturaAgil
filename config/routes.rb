Rails.application.routes.draw do

  #resources :records
  
  get '/records' => 'records#get'
  post '/records' => 'records#post'
  resources :vitalsign_histories
  resources :location_histories
  resources :safe_zones
  resources :collars
  resources :pets
  resources :pet_statuses
  resources :pet_types
  resources :owners
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # You can have the root of your site routed with "root"
  root 'site#index'
end
