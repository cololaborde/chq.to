Rails.application.routes.draw do

  root 'home#index'

  # rutas para administración de los links
  resources :link_accesses
  resources :links

  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }
  
  # ruta de acceso a los links
  get '/l/:slug', to: 'link_redirection#access', as: :public_link

  # ruta para el formulario de pw de un link privado
  post '/l/:slug/access_private', to: 'link_redirection#access_private', as: :access_private
  
  # para que cualquier subdominio no definido devuelva 404 y no un error
  match '*path', to: 'errors#not_found', via: :all

end
