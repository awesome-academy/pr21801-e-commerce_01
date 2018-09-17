class Admin::ChartsController < Admin::ApplicationController
  authorize_resource :class => false

  def index
    @revenue_by_week = Order.revenue_by_week
    @revenue_by_month = Order.revenue_by_month
    @rating_product = Product.by_average_rating
    @order_by_user = Order.by_user
    @order_status = Order.group_by_status
  end
end
