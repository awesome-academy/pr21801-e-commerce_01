module ApplicationHelper
  def format_price price
    number_to_currency(price, unit: "đ", delimiter: ".", precision: 0,
      format: "%n %u")
  end

  def order_status order, type
    result = link_to order.status, order_path(order.id), class: type
  end
end
