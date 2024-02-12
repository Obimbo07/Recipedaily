class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe # only: %i[index show]
  before_action :set_recipe_food, only: %i[edit update destroy]

  def index
    @recipe_foods = RecipeFood.all
    @recipes = Recipe.includes(:recipe_foods).all
  end

  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

  def new
    @recipe_food = RecipeFood.new
  end

  def edit
    # @recipe and @recipe_food are already set by set_recipe_food method
  end

  def create
    @recipe = Recipe.find(params.dig(:recipe_food, :recipe_id))
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Ingredient added successfully.'
    else
      render 'recipes/show'
    end
  end

  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe), notice: 'Recipe food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @recipe_food.destroy
      redirect_to @recipe_food.recipe, notice: 'Recipe food was successfully removed.'
    else
      redirect_to @recipe_food.recipe, alert: 'Failed to remove recipe food.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id]) if params[:recipe_id].present?
  end

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity).transform_values(&:to_i)
  end
end
