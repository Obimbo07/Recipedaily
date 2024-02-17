class Recipe < ApplicationRecord
  validates :name, :cooking_time, :description, :preparation_time, presence: true
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, class_name: 'Food'

  scope :public_recipes, -> { where(public: true) }

  # def total_price
  #   foods.sum(:price)
  # end

  def total_price
    recipe_foods.sum { |rf| rf.food.price * rf.quantity }
  end

  scope :general_shopping_list, lambda { |user|
    where(user_id: user.id).joins(:foods).where.not(foods: { id: user.foods.pluck(:id) })
  }

  def generate_shoping_list
    # Assuming you have a 'foods' association, adjust this based on your actual associations
    foods = self.foods

    # Perform logic to generate the shopping list
    foods.map do |food|
      {
        name: food.name,
        quantity: food.quantity, # Add your logic here
        price: food.price,
        total_price: food.quantity * food.price # You might want to calculate total price
      }
    end

    # Return the generated shopping list
  end
end
