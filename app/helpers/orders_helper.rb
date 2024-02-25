module OrdersHelper
  def date(datetime)
    return if datetime.nil?

    l datetime.to_date, format: :fr_short
  end

  def order_status_color(order)
    if order.pending?
      'bg-blue-100 text-blue-800'
    elsif order.cancelled?
      'bg-red-100 text-red-800'
    elsif order.delivered?
      'bg-green-100 text-green-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def suppliers_list(space)
    [[t('supplier_id', scope: 'activerecord.attributes.order'), nil]] +
      space.suppliers.order(:name).pluck(:name, :id)
  end

  def status_list
    [[t('status', scope: 'activerecord.attributes.order'), nil]] +
      Order::STATUS.to_a
  end
end
