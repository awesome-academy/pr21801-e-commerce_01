class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_order, only: [:show, :update]

  def index
    @search = current_user.orders.ransack params[:q]
    @orders = @search.result.all_order.page params[:page]
  end

  def show
    @search = @order.order_details.ransack params[:q]
    @items = @search.result
  end

  def create
    @order = current_user.orders.build order_params

    if @order.save
      flash[:success] = t "buy_product_success"
      UserMailer.order_success(@order).deliver_now
      session.delete :order
      @current_order = nil
      redirect_to root_url
    else
      flash[:success] = t "buy_product_failed"
      redirect_to root_url
    end
  end

  def update
    if @order.update_attributes order_params
      if params[:order][:status] == Settings.order_status.delivered
        flash[:success] = t "delivered_success"
      else
        flash[:success] = t "cancel_success"
      end
      redirect_to admin_order_path @order
    else
      flash[:danger] = t "cancel_failed"
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :total,
      order_details_attributes: [:id, :product_id, :quantity, :price])
  end

  def get_order
    redirect_to orders_path unless @order = Order.find_by(id: params[:id])
  end
end
