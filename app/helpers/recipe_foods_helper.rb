# app/helpers/recipe_foods_helper.rb
module RecipeFoodsHelper
  def calculate_value(recipe_food)
    number_to_currency(recipe_food.food.price * recipe_food.quantity)
  end
end
