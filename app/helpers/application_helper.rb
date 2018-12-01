module ApplicationHelper
  def admin_page?
    request.path.start_with?("/admin")
  end
end
