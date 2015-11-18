Rails.application.routes.draw do

  root "sessions#index"

  get '/login', to: "sessions#login", as: 'login'
  post '/login', to: "sessions#attempt_login"
  delete '/logout', to: "sessions#logout", as: 'logout'
  get '/signup', to: "users#signup", as: 'signup'
  get '/home', to: "sessions#index", as: 'home'
  post '/signup', to: "users#create"

  #Oauth Github
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :users, except: ['index','new'] do
    resources :snippets, shallow: true
  end
  #favorites
  get '/users/:user_id/favorites', to: "users#favorites", as: 'favorites'
  post '/users/:user_id/favorites', to: "favorites#create_favorite"
  delete '/favorite/:id', to: "favorites#destroy_favorite"

end
  