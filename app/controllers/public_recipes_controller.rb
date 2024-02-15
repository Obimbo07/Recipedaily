class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.where(public: true).includes(:user)
    @recipe_details = @public_recipes.map do |recipe|
      {
        recipe_name: recipe.name,
        user_name: recipe.user.name,
        total_food_items: recipe.recipe_foods.count
      }
    end
  end
end
