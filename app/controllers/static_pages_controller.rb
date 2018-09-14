class StaticPagesController < ApplicationController
  def home
    @hot_products = Product.hot_product
    @q = Product.ransack params[:q]
    @products = @q.result.get_product.page params[:page]
  end

  def about; end
end
