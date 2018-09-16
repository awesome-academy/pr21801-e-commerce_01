class Admin::CategoriesController < Admin::ApplicationController
  before_action :get_category, only: [:show, :edit, :update, :destroy]
  before_action :load_roots, only: [:show, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @search =  Category.ransack params[:q]
    @categories = @search.result.ordered_by_name.search_by_name(params[:search]).
      page(params[:page]).per params[:limit]
  end

  def new
    @category = Category.new
  end

  def show
    @products = @category.products.get_product
  end

  def edit; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "add_success_category"
      redirect_to admin_category_url @category
    else
      flash[:danger] = t "add_failed_category"
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
      redirect_to admin_category_url @category
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @category.products.present?
      message_category
    else
      if !@category.children.present?
        delete_category
      else
        found = false
        @category.descendents.each do |category|
          if category.products.present?
            found = true
            message_category
            break
          end
        end
        unless found
          delete_category
        end
      end
    end
  end

  private

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit :name, :description, :parent_id
  end

  def load_roots
    redirect_to root_url unless @categories = Category.roots(nil)
  end

  def message_category
    flash[:warning] = t "delete_warning"
    render :show
  end

  def delete_category
    if @category.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to admin_categories_url
  end
end
