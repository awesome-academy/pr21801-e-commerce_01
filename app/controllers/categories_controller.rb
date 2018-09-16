class CategoriesController < ApplicationController
  before_action :get_category
  before_action :load_roots
  load_and_authorize_resource

  def show
    products = Product.by_category((@category.children + [@category])
      .map(&:products).flatten.pluck(:id))
    @products = products.get_product.page(params[:page])
      .per params[Settings.product.featured]
  end

  private

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:id])
  end

  def load_roots
    redirect_to root_url unless @categories = Category.roots(nil)
  end
end
