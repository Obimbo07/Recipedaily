class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  
  has_many :recipes, dependent: :destroy       
  has_many :foods

  validates :name, presence: true

  def general_shopping_list
    Recipe.general_shopping_list(self)
  end
end
