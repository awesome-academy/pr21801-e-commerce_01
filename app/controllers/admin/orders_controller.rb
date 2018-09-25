class Admin::OrdersController < Admin::ApplicationController
  before_action :get_order, only: [:show, :update]
  load_and_authorize_resource

  def index
    @search = Order.order(created_at: :desc).ransack params[:q]
    @orders = @search.result
    respond_to do |format|
      format.html {@orders = @orders.page(params[:page]).per params[:limit]}
      format.csv {send_data @orders.to_csv, filename:"orders-#{Date.today}.csv"}
      format.xls {send_data @orders.to_csv(col_sep: "\t")}
    end
  end

  def show
    @search = @order.order_details.ransack params[:q]
    @items = @search.result
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "cancel_success"
      redirect_to orders_path
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
