class Admin::ProductsController < ApplicationController
  before_action :get_product, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def edit; end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = t "product_created"
      redirect_to admin_category_url @product.category
    else
      flash[:danger] = t "create_product_failed"
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "product_updated"
      redirect_to admin_category_url @product.category
    else
      flash[:danger] = t "update_product_failed"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "product_deleted"
    else
      flash[:danger] = t "delete_product_failed"
    end
    redirect_back fallback_location: admin_products_url
  end

  private

  def get_product
    redirect_to root_url unless @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit :name, :category_id, :price, :description,
      images_attributes: [:id, :image_url]
  end
end
