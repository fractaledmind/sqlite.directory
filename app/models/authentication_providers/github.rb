module AuthenticationProviders
  module GitHub
    extend self

    def key = "github"
    def label = "GitHub"

    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps
    def scopes = "read:user"

    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#1-request-a-users-github-identity
    def authorize_url
      return local_uri("/developer/oauth/authorize") if Rails.env.development?

      URI("https://github.com/login/oauth/authorize")
    end

    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#2-users-are-redirected-back-to-your-site-by-github
    def token_url
      return local_uri("/developer/oauth/access_token") if Rails.env.development?

      URI("https://github.com/login/oauth/access_token")
    end
    # see: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#3-use-the-access-token-to-access-the-api
    def user_info_url
      return local_uri("/developer/oauth/user_info") if Rails.env.development?

      URI("https://api.github.com/user")
    end

    def client_id = Rails.application.credentials.github.oauth.client_id
    def client_secret = Rails.application.credentials.github.oauth.client_secret

    private

    def local_uri(path)
      URI::HTTP.build(
        path: path,
        **Rails.application.config.action_controller.default_url_options)
    end
  end
end