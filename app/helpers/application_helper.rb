module ApplicationHelper
  def admin_page?
    request.path.start_with?("/admin")
  end
  
  def nav_link(title, path)
    content_tag :li, :class => "nav-item" do
      link_to title, path, :class => "nav-link"
    end
  end
end
