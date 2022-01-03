class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :google_oauth2

  def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
      
      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        # auth = request.env["omniauth.auth"]
        # @user.access_token = auth.credentials.token
        # @user.expires_at = auth.credentials.expires_at
        # @user.refresh_token = auth.credentials.refresh_token
        # @user.save!
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end
end
