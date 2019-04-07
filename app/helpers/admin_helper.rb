module AdminHelper
  def delete_user_link(user)
    return if user.admin?
    
    link_to(
      "Delete",
      admin_user_path(user),
      :method => :delete,
      :class => "btn btn-small btn-danger",
      :data => {
        :confirm => "Are you sure?",
        :disable_with => "Please wait..."
      }
    )
  end
end