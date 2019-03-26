class AddImageUrlToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :img_url, :string
  end
end
