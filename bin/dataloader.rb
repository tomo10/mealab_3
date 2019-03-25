class Dataloader

    def get_data(url)
      response = RestClient.get(url)
      data = JSON.parse(response)
    end

    def load_data

      cats = get_data("https://www.themealdb.com/api/json/v1/1/list.php?c=list")
      ing = get_data("https://www.themealdb.com/api/json/v1/1/list.php?i=list")
      area = get_data("https://www.themealdb.com/api/json/v1/1/list.php?a=list")

      # get all catergories.
      cats["meals"].each do |cat|
          cat = Category.create(name: cat["strCategory"])
      end

      byebug

    end

end
