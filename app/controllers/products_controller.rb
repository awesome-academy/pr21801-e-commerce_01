class ProductsController < ApplicationController
  before_action :get_product

  def show
    @comments = @product.comments.hash_tree(limit_depth: 2)
    @products = @product.category.products
  end

  private

  def get_product
    redirect_to root_url unless @product = Product.find_by(id: params[:id])
  end
end
