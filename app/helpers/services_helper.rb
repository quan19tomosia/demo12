module ServicesHelper
  def status_collection
    return Service.statuses.map{ |k,v| [k.humanize.capitalize, v]}.push(["All statuses", ""]).reverse
  end

  def number_to_currency_vi(number)
    number_to_currency(number, unit: "VNĐ", separator: ",", delimiter: ".", format: "%n %u")
  end

  def label_class(status)
    case status
    when 'inactive'
      return 'danger'
    when 'active'
      return 'success'
    else
      return 'info'
    end
  end
end
