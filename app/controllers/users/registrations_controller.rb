class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def update
    super
  end

  def create
    correct_answer = Rails.application.credentials.captcha_answer.downcase

    if params[:captcha_answer].to_s.downcase != correct_answer
      flash[:alert] = "Odgovor na sigurnosno pitanje nije tačan."
      redirect_to new_user_registration_path
    else
      super
    end
  end

  protected

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:streets, towns: []])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:streets])
  end
end
