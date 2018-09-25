class Admin::DashboardsController < Admin::ApplicationController
  authorize_resource :class => false

  def index
    @new_user = User.new_user(1.day.ago, Time.zone.now).count
    @new_order = Order.new_order(1.day.ago, Time.zone.now).count
    @popular_product = Product.hot_product.first
    @favourite_product = Product.like_most.first
    @number_order = Order.all.size
    @number_product = Product.all.size
    @number_user = User.all.size
  end
end
