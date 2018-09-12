module CartsHelper
  def current_order
    @current_order = session[:order]
  end

  def total_cart
    @total_cart = 0;
    @total_price = 0;
    session[:order].each do |cart_item|
      @total_cart += cart_item["quantity"].to_i
      @total_price += cart_item["price"].to_i * cart_item["quantity"].to_i
    end
  end

  def quantity_item
    quantity = 0
    unless session[:order].nil?
      session[:order].each do |order|
        quantity += order["quantity"].to_i
      end
    end
    return quantity
  end

  def create_order
    if session[:order]
      sum = 0
      session[:order].each do |item|
        sum += item["quantity"] * item["price"]
      end
      @order = Order.new total: sum
      session[:order].each do |order|
        @order.order_details.build product_id: order["product_id"],
          quantity: order["quantity"], price: order["price"]
      end
    end
  end
end
