class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit destroy]
  before_action :authenticate_user!, except: %i[index show new]

  def index
    @foods = if user_signed_in?
               Food.where(user_id: current_user.id)
             else
               Food.all
             end
  end

  def show
    return if @food

    redirect_to foods_path, flash[alert] = 'Food not found.'
  end

  def edit
    # No need for additional code here, just rendering the edit view
  end

  def new
    @food = Food.new
  end

  # POST /foods or /foods.json
  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to @food
      flash[:notice] = 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url
    flash[:notice] = 'Food was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
