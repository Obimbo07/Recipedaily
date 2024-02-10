class GeneralShoppingListController < ApplicationController
  def index
    @missing_foods = current_user.general_shopping_list
    @total_food_items = @missing_foods.count
    @total_price = @missing_foods.sum(:price)
  end
end
