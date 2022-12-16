module ApplicationHelper
  include Pagy::Frontend

  def current_path?(path)
    return 'active' if request.path == path
    ''
  end
end
