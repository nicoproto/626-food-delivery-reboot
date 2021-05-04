require_relative "../views/meals_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    display_all
  end

  def add
    # 1. Ask user for name (view)
    name = @meals_view.ask_user_for(:name)
    # 2. Ask user for price (view)
    price = @meals_view.ask_user_for(:price)
    # 3. Create new Meal instance
    meal = Meal.new(name: name, price: price)
    # 4. Store it in the repository (repo)
    @meal_repository.create(meal)
    display_all
  end

  def display_all
    # 1. Get meals (repo)
    meals = @meal_repository.all
    # 2. Display in terminal (view)
    @meals_view.display(meals)
  end
end