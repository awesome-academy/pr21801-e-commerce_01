module Admin::OrdersHelper
  def order_status_dashboard order, type
    result = link_to order.status, admin_order_path(order.id), class: type
  end
end
