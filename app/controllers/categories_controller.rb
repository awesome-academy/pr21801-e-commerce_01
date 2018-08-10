class CategoriesController < ApplicationController
  before_action :get_category, only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def show
    @categories = Category.roots(nil)
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "add_success_category"
      redirect_to @category
    else
      flash[:danger] = t "add_failed_category"
      render :new
    end
  end

  private

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit :name, :description, :parent_id
  end
end
