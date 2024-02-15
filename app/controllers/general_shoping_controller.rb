class GeneralShopingController < ApplicationController
  before_action :set_recipe, only: [:generate_shopping_list]

  def generate_shopping_list
    @shopping_list = @recipe.generate_shopping_list
    @recipe = Recipe.find(params[:id])
    
    # Generate the shopping list for the recipe
    @shopping_list = @recipe.generate_shopping_list

    # Calculate the total quantity and total price
    @total_quantity = @shopping_list.sum { |item| item[:quantity] }
    @total_price = @shopping_list.sum { |item| item[:total_price] }

    # You might want to render or redirect somewhere, or handle this in a JavaScript response (respond_to(&:js))
  end

  def index
    @food_items = Food.where('quantity < 0')
    @total_amount = 0
    @count = 0
    @food_items.each do |food_item|
      food_item.quantity = food_item.quantity.negative? ? food_item.quantity.abs : food_item.quantity
      amount = food_item.quantity * food_item.price
      @total_amount += amount
      @count += 1
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
