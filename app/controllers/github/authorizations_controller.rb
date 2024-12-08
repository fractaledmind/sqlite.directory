module GitHub
  class AuthorizationsController < ApplicationController
    include OAuthController

    skip_before_action :ensure_user_authenticated!
    before_action :user_authenticated?

    provider AuthenticationProviders::GitHub

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
            notice: "Successfully updated #{provider_label} account"

        elsif Current.user.present?
          Current.user.update(
            avatar_url: auth_info.dig("info", "avatar_url"),
            github_username: auth_info.dig("info", "login"),
            twitter_username: auth_info.dig("info", "twitter_username")
          )
          redirect_to after_oauth_path,
            notice: "Successfully connected #{provider_label} account"

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
              notice: "Signed in successfully via #{provider_label}"
          else
            redirect_to root_path,
              alert: "Authentication with #{provider_label} failed: invalid user details"
          end
        end
      end

      def authorization_failed
        redirect_to root_path,
          alert: "Authentication with #{PROVIDER_LABEL} failed"
      end
  end
end
