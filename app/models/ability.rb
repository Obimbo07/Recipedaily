class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Assign an empty User object if user is nil

    # Define abilities for the user
    if user.present?
      can :manage, Food, user_id: user.id
      can :manage, Recipe, user_id: user.id
      can :manage, RecipeFood, recipe: { user_id: user.id }
      can :read, Recipe, :published # Logged-in users can read all published recipes

      # Additional abilities based on user roles or conditions (if applicable)
    else
      can :read, Recipe, published: true # Non-logged-in users can only read published recipes
    end
  end
end
