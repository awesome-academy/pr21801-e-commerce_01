class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :get_product

  def show
    @comments = @product.comments.hash_tree(limit_depth: 2)
    @products = @product.category.products
    @product.promotion_details.each do |i|
      if Time.zone.today.between?(i.start_date, i.end_date)
        @percent = i.promotion.percent
      end
    end
  end

  private

  def get_product
    redirect_to root_url unless @product = Product.friendly.find_by_slug(params[:id])
  end
end
