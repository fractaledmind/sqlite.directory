module GitHub
  class AuthorizationsController < ApplicationController
    include OAuthController

    PROVIDER_KEY = "github"
    PROVIDER_LABEL = "GitHub"
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#1-request-a-users-github-identity
    AUTHORIZE_URL = URI("https://github.com/login/oauth/authorize")
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps
    SCOPE = "read:user user:email"
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#2-users-are-redirected-back-to-your-site-by-github
    TOKEN_URL = URI("https://github.com/login/oauth/access_token")
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#3-use-the-access-token-to-access-the-api
    USER_INFO_URL = URI("https://api.github.com/user")
    CLIENT_ID = Rails.application.credentials.github.oauth.client_id
    CLIENT_SECRET = Rails.application.credentials.github.oauth.client_secret

    private

      def authorization_succeeded(auth_info)
        if (connected_account = User::ConnectedAccount.for_auth(auth_info)).present?
          connected_account.update(connected_account_params)
          sign_in(user: connected_account.user)
          redirect_to after_oauth_path,
            notice: "Successfully updated GitHub account"

        elsif Current.user.present?
          Current.user.connected_accounts.create(connected_account_params)
          redirect_to after_oauth_path,
            notice: "Successfully connected GitHub account"

        else
          user = User.new(
            screen_name: auth_info.dig(:info, :login) ||
                         auth_info.dig(:info, :email).split("@").first,
            full_name: auth_info.dig(:info, :name),
            email: auth_info.dig(:info, :email)
          )
          user.connected_accounts.new(connected_account_params)

          if user.save
            sign_in(user:)
            redirect_to after_oauth_path,
              notice: "Signed in successfully via GitHub"
          else
            redirect_to new_session_path,
              alert: error_alert
          end
        end
      end

      def authorization_failed
        redirect_to new_session_path,
          alert: error_alert
      end
  end
end
