Rails.application.routes.draw do

  root 'home#index'

  # rutas para administración de los links
  resources :link_accesses
  resources :ephemeral_links
  resources :private_links
  resources :temporal_links
  resources :regular_links

  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }
  
  # ruta de acceso a los links
  get '/l/:slug', to: 'link_redirection#access'

  # ruta para el formulario de pw de un link privado
  post '/l/:id/access_private', to: 'links#access_private', as: :access_private
  
  # para que cualquier subdominio no definido devuelva 404 y no un error
  match '*path', to: 'errors#not_found', via: :all

end
