class Products::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    if @product.likes.where(user_id: current_user.id).first_or_create
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    if @product.likes.where(user_id: current_user.id).destroy_all
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    else
      redirect_to root_url
    end
  end

  private

  def set_product
    redirect_to root_url unless @product = Product.find_by(id: params[:product_id])
  end
end
