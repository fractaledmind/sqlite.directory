module GitHub
  class AuthorizationsController < ApplicationController
    include OAuthController

    skip_before_action :ensure_user_authenticated!
    before_action :user_authenticated?

    PROVIDER_KEY = "github"
    PROVIDER_LABEL = "GitHub"
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#1-request-a-users-github-identity
    AUTHORIZE_URL = URI("https://github.com/login/oauth/authorize")
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps
    SCOPE = "read:user"
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#2-users-are-redirected-back-to-your-site-by-github
    TOKEN_URL = URI("https://github.com/login/oauth/access_token")
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#3-use-the-access-token-to-access-the-api
    USER_INFO_URL = URI("https://api.github.com/user")
    CLIENT_ID = Rails.application.credentials.github.oauth.client_id
    CLIENT_SECRET = Rails.application.credentials.github.oauth.client_secret

    private

      def authorization_succeeded(auth_info)
        if (user = User.find_by(github_uid: auth_info["uid"])).present?
          user.update(
            avatar_url: auth_info.dig("info", "avatar_url"),
            github_username: auth_info.dig("info", "login"),
            twitter_username: auth_info.dig("info", "twitter_username")
          )
          sign_in(user:)
          redirect_to after_oauth_path,
            notice: "Successfully updated GitHub account"

        elsif Current.user.present?
          Current.user.update(
            avatar_url: auth_info.dig("info", "avatar_url"),
            github_username: auth_info.dig("info", "login"),
            twitter_username: auth_info.dig("info", "twitter_username")
          )
          redirect_to after_oauth_path,
            notice: "Successfully connected GitHub account"

        else
          user = User.new(
            github_uid: auth_info["uid"],
            avatar_url: auth_info.dig("info", "avatar_url"),
            github_username: auth_info.dig("info", "login"),
            twitter_username: auth_info.dig("info", "twitter_username")
          )

          if user.save
            sign_in(user:)
            redirect_to after_oauth_path,
              notice: "Signed in successfully via GitHub"
          else
            redirect_to root_path,
              alert: "Authentication with GitHub failed: invalid user details"
          end
        end
      end

      def authorization_failed
        redirect_to root_path,
          alert: "Authentication with GitHub failed"
      end
  end
end
