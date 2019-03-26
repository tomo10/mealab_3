# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Recipe.destroy_all
Meal.destroy_all
Category.destroy_all
Ingredient.destroy_all

def get_data(url)
  response = RestClient.get(url)
  data = JSON.parse(response)
end

  categories = get_data("https://www.themealdb.com/api/json/v1/1/list.php?c=list")
  ingredients = get_data("https://www.themealdb.com/api/json/v1/1/list.php?i=list")
  # allmeals = get_data("https://www.themealdb.com/api/json/v1/1/search.php?s=a")

  flat = []
  meal = []
  categories["meals"].each do |category|
    m = get_data("https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category["strCategory"]}")
    meal << m["meals"]
    flat = meal.flatten
  end

  array_ids = flat.map {|f| f["idMeal"]}

  meals_array = []
  allmeals = []
  array_ids.each do |id|
    m = get_data("https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}")
    meals_array << m["meals"]
    allmeals = meals_array.flatten
  end


  # get all catergories.
  categories["meals"].each do |category|
    category = Category.create(name: category["strCategory"])
  end

  # get all ingredients.
  ingredients["meals"].each do |ingredient|
    ingredient = Ingredient.create(name: ingredient["strIngredient"])
  end

  # get all meals
  allmeals.each do |meal|
    new_meal = Meal.new()
    new_meal.name = meal["strMeal"]
    new_meal.img_url = meal["strMealThumb"]
    category1 = Category.find_by name: meal["strCategory"]
      new_meal.category_id = category1.id
      new_meal.save
      counter = 1
        while counter < 21
          if meal["strIngredient" + counter.to_s] != nil && meal["strIngredient" + counter.to_s] != ""
            strIngredient = meal["strIngredient" + counter.to_s].split.map(&:capitalize).join(' ')
            ingredient1 = Ingredient.find_by name: strIngredient
              if ingredient1 != nil
                recipe1 = Recipe.new()
                recipe1.meal_id = new_meal.id
                recipe1.ingredient_id = ingredient1.id
                #get measures
                recipe1.measure = meal["strMeasure" + counter.to_s]
                recipe1.save
              end
          end
      counter+=1
      end
  end
