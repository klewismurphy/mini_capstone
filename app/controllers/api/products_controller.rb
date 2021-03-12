class Api::ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]

  def index
    if params[:sort] == "price"
      @products = Product.order("#{params[:sort]}" => "#{params[:sort_order]}")
      render "index.json.jb"
    elsif params[:discount] == "true"
      @products = Product.where("price < 10")
      render "index.json.jb"
    else
      @products = Product.all
      render "index.json.jb"
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    render "show.json.jb"
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
    )
    @product.save

    if @product.save == false
      render json: { Error: @product.errors.full_messages }
    else
      render "show.json.jb"
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    @product.save
    render "show.json.jb"
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: { message: "Item has been deleted." }
  end
end
