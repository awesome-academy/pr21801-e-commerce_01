class ProductsController < ApplicationController
  load_and_authorize_resource find_by: :slug
  before_action :get_product

  def index
    q = params[:search]
    if q
      @products = Product.search(name_cont: q).result
    else
      @products = Product.all
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @comments = @product.comments.hash_tree(limit_depth: 2)
    if @product.category.parent.present?
      @products = @product.category.parent.children.map(&:products).flatten
    else
      @products = @product.category.products
    end
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
