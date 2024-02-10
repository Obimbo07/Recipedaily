class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, class_name: 'Food'

  scope :public_recipes, -> { where(public: true) }

  def total_price
    foods.sum(:price)
  end

  scope :general_shopping_list, lambda { |user|
    where(user_id: user.id).joins(:foods).where.not(foods: { id: user.foods.pluck(:id) })
  }
end
