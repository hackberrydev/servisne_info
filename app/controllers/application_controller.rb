class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  before_action :set_sentry_context

  private

  def set_sentry_context
    if signed_in?
      Sentry.set_user(id: current_user.id)
    end
  end
end
