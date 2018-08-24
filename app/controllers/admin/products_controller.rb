class Admin::ProductsController < ApplicationController
  load_and_authorize_resource

  def new
    @product = Product.new
  end

  def create
    @product = Product.create product_params
    if @product.save
      flash[:success] = t "product_created"
      redirect_to admin_category_url(@product.category)
    else
      flash[:danger] = t "create_product_failed"
      redirect_to new_admin_product_url
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :category_id, :price, :description
  end
end
