class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods

  validates :name, presence: true
  validates :description, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :public, inclusion: { in: [true, false] }
end
