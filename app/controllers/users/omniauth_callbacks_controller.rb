class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      redirect_to new_user_registration_url
    end
  end
end