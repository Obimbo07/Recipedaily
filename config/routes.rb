Rails.application.routes.draw do
  get '/general_shopping_list', to: 'general_shopping_list#index'
  get '/public_recipes', to: 'recipes#public_recipes'
  root 'recipes#public_recipes' 

  resources :recipe_foods
  resources :foods
  resources :recipes do 
    patch 'toggle_public', on: :member
    get 'generate_shopping_list', on: :member
    resources :recipe_foods, only: %i[new create edit update destroy]
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
end
