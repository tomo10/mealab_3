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



  cats = get_data("https://www.themealdb.com/api/json/v1/1/list.php?c=list")
  ing = get_data("https://www.themealdb.com/api/json/v1/1/list.php?i=list")
  allmeals = get_data("https://www.themealdb.com/api/json/v1/1/search.php?s=%")

  # get all catergories.
  cats["meals"].each do |cat|
      cat = Category.create(name: cat["strCategory"])
  end

  # get all ingredients.
  ing["meals"].each do |cat|
      cat = Ingredient.create(name: cat["strIngredient"])
  end

  # get all meals
  allmeals["meals"].each do |meal|

      m = Meal.new()
      m.name = meal["strMeal"]
      c1 = Category.find_by name: meal["strCategory"]
      m.category_id = c1.id
      m.save

      counter = 1

      while counter < 21

          if meal["strIngredient" + counter.to_s] != nil && meal["strIngredient" + counter.to_s] != ""

              strIngredient = meal["strIngredient" + counter.to_s].split.map(&:capitalize).join(' ')

              i1 = Ingredient.find_by name: strIngredient

              if i1 != nil
                r1 = Recipe.new()
                r1.meal_id = m.id
                r1.ingredient_id = i1.id
                #get measures
                r1.measure = meal["strMeasure" + counter.to_s]
                r1.save
              end

          end

          counter+=1

      end

  end
