class Api::ProductsController < ApplicationController
  def all_action
    @all = Product.all

    @allproducts = []
    index = 0

    while index < @all.length
      product = {
        id: @all[index].id,
        name: @all[index].name,
        price: @all[index].price,
        image_url: @all[index].image_url,
        description: @all[index].description,
      }
      @allproducts << product
      index += 1
    end

    render "allproducts.json.jb"
  end
end
