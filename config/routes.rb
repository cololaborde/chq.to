Rails.application.routes.draw do
  resources :ephemeral_links
  resources :private_links
  resources :temporal_links
  resources :regular_links
  root 'home#index'

  # resources :regular_links, controller: 'links', type: 'RegularLink'
  # resources :links, param: :type, except: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }
  
  post '/l/:id/access_private', to: 'links#access_private', as: :access_private
  get '/l/:slug', to: 'links#access'
  match '*path', to: 'errors#not_found', via: :all

end
