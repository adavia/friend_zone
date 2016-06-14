class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :username,
      :birthday, :gender, :password, :password_confirmation,
      :address, :latitude, :longitude)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :birthday, :gender,
      :password, :password_confirmation, :current_password,
      :address, :latitude, :longitude)
  end
end
