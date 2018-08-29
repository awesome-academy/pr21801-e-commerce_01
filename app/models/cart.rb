class Cart
  attr_accessor :product_id, :name, :price, :quantity

  def initialize product_id, name, price, quantity
    @product_id = product_id
    @name = name
    @price = price
    @quantity = quantity
  end
end
