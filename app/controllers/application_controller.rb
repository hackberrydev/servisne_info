class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  before_action :set_raven_context

  private

  def set_raven_context
    if signed_in?
      Raven.user_context(id: current_user.id)
    end
  end
end
