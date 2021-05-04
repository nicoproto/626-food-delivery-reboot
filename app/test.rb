require_relative 'repositories/meal_repository'

repo = MealRepository.new('data/meals.csv')
p repo.all