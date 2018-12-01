module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!

    private

    def authenticate_admin!
      not_found unless current_user.admin?
    end

    def not_found
      raise ActionController::RoutingError, "Not Found"
    end
  end
end

