Rails.application.routes.draw do
  resources :regular_links
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

  #get '/l/:slug', to: 'links#show', as: :regular_link
  #get '/t/:slug', to: 'links#show_temporal', as: :temporal_link
  #get '/p/:slug', to: 'links#show_private', as: :private_link
  #get '/e/:slug', to: 'links#show_ephemeral', as: :ephemeral_link

end
