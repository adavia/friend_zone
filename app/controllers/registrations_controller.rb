class RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :username,
      :birthday, :gender, :password, :password_confirmation,
      :address, :latitude, :longitude)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :username, :birthday, :gender,
      :password, :password_confirmation, :current_password,
      :address, :latitude, :longitude)
    end
  end
end
