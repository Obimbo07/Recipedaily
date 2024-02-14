Rails.application.routes.draw do
  get '/public_recipes', to: 'recipes#public_recipes'
  root 'recipes#public_recipes'
  
  resources :recipe_foods
  resources :foods
  resources :recipes do
    member do
      patch 'toggle_public'
    end
    resources :recipe_foods, only: %i[new create edit update destroy]
  end
  get 'general_shoping_list', to: 'general_shoping#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
end
