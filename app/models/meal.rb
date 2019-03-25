class Meal < ApplicationRecord

    belongs_to :category
    has_many :recipes
    has_many :ingredients, through: :recipes

end
