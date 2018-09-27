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

  def link_to_add_fields name, f, association, **args
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render association.to_s.singularize, f: builder
    end
    link_to name, "#", class: "add_fields " + args[:class],
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def status_promotion promotion
    pd = promotion.promotion_details.first
    if Time.zone.today.between?(pd.start_date, pd.end_date)
      status = t "going_on"
    elsif Time.zone.today < pd.start_date
      status = t "comming_soon"
    elsif pd.end_date < Time.zone.today
      status = t "ended"
    end
  end
end
