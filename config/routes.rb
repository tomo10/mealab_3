Rails.application.routes.draw do

  get '/', to: "application#hello", as: "meals_hello"
  # post '/search', to: 'meals#search', as: "meals_search"
  # post '/login', to: 'meals#login', as: "meals_login"
  # get '/search/show', to: 'meals#show', as: "meals_show"

  resources :recipes, only: [:show, :index]
  resources :ingredients
  resources :meals
  resources :categories

  #user account management
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user'

  # sessions management
  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'sessions'
  post '/logout', to: 'sessions#destroy', as: 'logout'

  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
