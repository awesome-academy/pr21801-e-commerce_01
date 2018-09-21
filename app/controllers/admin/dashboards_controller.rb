class Admin::DashboardsController < Admin::ApplicationController
  authorize_resource :class => false

  def index
    @new_user = User.new_user(Time.zone.today).count
    @new_order = Order.new_order(Time.zone.today).count
    @popular_product = Product.hot_product.first
    @favourite_product = Product.like_most.first
  end
end
