class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build order_params

    if @order.save
      flash[:success] = t ".buy_product_success"
      session.delete :order
      @current_order = nil
      redirect_to root_url
    else
      flash[:success] = t ".buy_product_failed"
      redirect_to root_url
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :total,
      order_details_attributes: [:id, :product_id, :quantity, :price])
  end
end
