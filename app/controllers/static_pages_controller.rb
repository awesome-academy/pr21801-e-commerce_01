class StaticPagesController < ApplicationController
  def home
    @hot_products = Product.hot_product.includes(:images)
    @q = Product.ransack params[:q]
    @products = @q.result.get_product.includes(:images).page(params[:page])
      .per(Settings.product.limit)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def about; end
end
