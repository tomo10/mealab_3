Rails.application.routes.draw do

  get '/', to: "application#hello", as: "meals_hello"
  post '/search', to: 'meals#search', as: "meals_search"
  post '/login', to: 'meals#login', as: "meals_login"
  get '/search/show', to: 'meals#show', as: "meals_show"

  # resources :recipes
  # resources :ingredients
  # resources :meals
  # resources :categories
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
