class Admin::PromotionsController < Admin::ApplicationController
  load_and_authorize_resource
  before_action :load_products, only: [:new, :edit]

  def index
    @promotions = Promotion.includes(:promotion_details).all
      .order(created_at: :desc).page params[:page]
  end

  def new
    @promotion = Promotion.new
    @promotion.promotion_details.build
  end

  def edit; end

  def create
    @promotion = Promotion.new promotion_params

    if @promotion.save
      flash[:success] = t "promotion_created"
      redirect_to admin_promotions_url
    else
      flash[:danger] = t "create_promotion_failed"
      render :new
    end
  end

  def update
    if @promotion.update_attributes promotion_params
      flash[:success] = t "promotion_updated"
      redirect_to admin_promotions_url
    else
      flash[:danger] = t "update_promotion_failed"
      render :edit
    end
  end

  private

  def load_products
    @products = Product.all
  end

  def promotion_params
    params.require(:promotion).permit :content, :percent,
      promotion_details_attributes: [:id, :product_id, :start_date, :end_date]
  end
end
