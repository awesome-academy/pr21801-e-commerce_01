module ApplicationHelper
  def format_price price
    number_to_currency(price, unit: "đ", delimiter: ".", precision: 0,
      format: "%n %u")
  end

  def order_status order, type
    result = link_to order.status, order_path(order.id), class: type
  end

  def count_order product
    total_quantity = 0
    product.order_details.each do |item|
      total_quantity += item.quantity
    end
    total_quantity
  end
end
