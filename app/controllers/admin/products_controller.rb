class Admin::ProductsController < Admin::ApplicationController
  before_action :get_product, only: [:edit, :show, :update, :destroy]
  load_and_authorize_resource find_by: :slug

  def index
    @q = Product.all.ransack params[:q]
    @products = @q.result.includes :images, :category, :order_details
    @q.build_sort if @q.sorts.empty?

    respond_to do |format|
      format.html {@products = @products.page(params[:page]).per params[:limit]}
      format.csv {send_data @products.to_csv, filename:"products-#{Date.today}.csv"}
      format.xls {send_data @products.to_csv(col_sep: "\t")}
    end
  end

  def new
    @product = Product.new
    @product.images.build
    @product.build_feature
  end

  def edit; end

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

  def import
    if params[:file].present?
      Product.import(params[:file])
      redirect_to admin_products_path, notice: t("import_success")
    else
      redirect_to admin_products_path, notice: t("import_failed")
    end
  end

  private

  def get_product
    redirect_to root_url unless @product = Product.friendly.find_by_slug(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :category_id, :price, :description,
      images_attributes: [:id, :image_url], feature_attributes: [:screen, :camera,
      :cpu, :ram, :rom, :pin])
  end
end
