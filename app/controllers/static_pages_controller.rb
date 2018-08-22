class StaticPagesController < ApplicationController
  def home
    @products = Product.get_product
    @like_products = Product.like_most
  end

  def about
  end
end
