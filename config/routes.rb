Rails.application.routes.draw do
  get '/general_shopping_list', to: 'general_shopping_list#index'
  resources :recipe_foods
  resources :foods
  resources :recipes do 
    patch 'toggle_public', on: :member

  resources :recipe_foods, only: [:new, :create]
  end
  get '/public_recipes', to: 'recipes#public_recipes'
  root 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'

  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
