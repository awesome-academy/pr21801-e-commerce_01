class Admin::OrdersController < Admin::ApplicationController
  before_action :get_order, only: [:show, :update]
  load_and_authorize_resource

  def index
    @search = Order.order(created_at: :desc).ransack params[:q]
    @orders = @search.result.page(params[:page]).per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @orders.to_csv, filename:"orders-#{Date.today}.csv"}
      format.xls {send_data @orders.to_csv(col_sep: "\t")}
    end
  end

  def show
    @search = @order.order_details.ransack params[:q]
    @items = @search.result
  end

  private

  def get_order
    redirect_to orders_path unless @order = Order.find_by(id: params[:id])
  end
end
