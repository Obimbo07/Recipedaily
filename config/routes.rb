Rails.application.routes.draw do
  root 'recipes#public' 
  get 'public_recipes', to: 'public_recipes#index', as: :public_recipes
  
  resources :public_recipes, only: [:index]
  resources :recipe_foods
  resources :foods
  resources :recipes do
    put 'toggle_public', on: :member
    resources :recipe_foods
  end
  get 'general_shopping_list', to: 'general_shopping_list#index' 
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
end
