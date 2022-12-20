module ApplicationHelper
  include Pagy::Frontend

  def current_path?(path)
    return 'active' if request.path == path
    ''
  end

  def number_to_phone_vi(phone)
    number_to_phone(phone.sub!(/^0/, ""), country_code: 84) unless phone.blank?
  end
end
