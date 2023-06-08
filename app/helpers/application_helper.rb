module ApplicationHelper
  def admin_page?
    request.path.start_with?("/admin")
  end

  def nav_link(title, path)
    li_class = "nav-item"
    li_class << " active" if request.path == path

    content_tag :li, class: li_class do
      link_to title, path, class: "nav-link"
    end
  end
end
