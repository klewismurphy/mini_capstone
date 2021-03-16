class Api::CartedProductsController < ApplicationController
  def create
    # user is only inputting product_id and quantity
    @cartedproduct = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted",
    )
    @cartedproduct.save
    @product = Product.find_by(id: @cartedproduct.product_id)
    render "show.json.jb"
  end

  def index
    @cps = CartedProduct.where(user_id: current_user.id)
    @cps = @cps.where(status: "carted")
    render "index.json.jb"
  end

  def destroy
    @cartedproduct = CartedProduct.find_by(id: params[:id])
    @product = Product.find_by(id: @cartedproduct.product_id)
    @cartedproduct.status = "removed"
    @cartedproduct.save
    render "show.json.jb"
  end
end
