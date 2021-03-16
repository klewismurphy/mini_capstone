class Api::OrdersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :create]

  def create
    @cps = CartedProduct.where(user_id: current_user.id)
    @cps = @cps.where(status: "carted")
    @calc_subtotal = 0

    @cps.each do |cp|
      product = Product.find_by(id: cp.product_id)
      tempsubtotal = product.price * cp.quantity
      @calc_subtotal = @calc_subtotal + tempsubtotal
    end

    # calc_subtotal = product.price * params[:quantity].to_i
    calc_tax = @calc_subtotal * 0.09 #another way to do it
    # calc_tax = params[:quantity].to_i * product.tax
    calc_total = @calc_subtotal + calc_tax

    @order = Order.new(
      user_id: current_user.id,
      subtotal: @calc_subtotal,
      # subtotal should be 95
      total: calc_total,
      #total shoudl be 887.26
      tax: calc_tax,
      # tax should be 73.26
    )
    @order.save

    @cps.each do |cp|
      cp.status = "purchased"
      cp.order_id = @order.id
      cp.save
    end

    render "show.json.jb"
  end

  def index
    @orders = current_user.orders
    # @orders = Order.where(user_id: current_user.id) #another way to do it
    render "index.json.jb"
  end

  def show
    # @order = Order.find_by(id: params[:id])
    @order = current_user.orders.find_by(id: params[:id])
    render "show.json.jb"
  end
end
