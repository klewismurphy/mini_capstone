class Api::OrdersController < ApplicationController
  def create
    product = Product.find_by(id: params[:product_id])
    calc_subtotal = product.price * params[:quantity].to_i
    calc_tax = calc_subtotal * 0.09
    calc_total = calc_subtotal + calc_tax

    @order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: calc_subtotal,
      total: calc_total,
      tax: calc_tax,
    )
    @order.save
    render "show.json.jb"
  end

  def index
    @orders = current_user.orders
    render "index.json.jb"
  end

  def show
    @order = Order.find_by(id: params[:id])
    render "show.json.jb"
  end
end