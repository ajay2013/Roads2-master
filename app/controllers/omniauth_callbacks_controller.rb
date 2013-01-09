class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Generate methods facebook and twitter
  ["facebook"].each do |provider|
    self.class_eval "def #{provider}; sign_in_through_provider(\"#{provider}\"); end"
  end

  private

  # Generic method to sign user in through given provider.
  # Provider should be string representing calling method name,
  # e.g. "facebook", "twitter"
  def sign_in_through_provider(provider)
    @user = User.find_for_provider_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, email: @user.email) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end
end
