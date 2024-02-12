class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :food_id, :quantity, presence: true
end
