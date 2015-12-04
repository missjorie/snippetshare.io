Rails.application.routes.draw do

  root "sessions#index"

  get '/login', to: "sessions#login", as: 'login'
  post '/login', to: "sessions#attempt_login"
  get '/admin', to: "sessions#admin", as: 'admin'
  post '/login', to: "sessions#attempt_login"
  delete '/logout', to: "sessions#logout", as: 'logout'
  get '/home', to: "sessions#index", as: 'home'

  #Oauth Github
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :users, except: ['index', 'new'] do
    resources :snippets, shallow: true
  end
  # resources :users, only: [] do
  #   resources :favorites, except: ['show']
  # end


end
  

  