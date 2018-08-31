class CartsController < ApplicationController
  before_action :get_product, only: :create

  def index; end

  def create
    unless session[:order].present?
      session[:order] = []
    end

    item = Cart.new(@product.id, @product.name, @product.price,
      Settings.order_details.quantity.default)
    item_index = session[:order].find_index {|n| n["product_id"] == item.product_id}

    if item_index.nil?
      session[:order] << item
    else
      quantity = session[:order][item_index]["quantity"]
      session[:order][item_index]["quantity"] = quantity + 1
    end
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end
  end

  private

  def get_product
    redirect_to root_url unless @product = Product.find_by(id: params[:product_id])
  end
end
