module OAuthController
  extend ActiveSupport::Concern

  SIGN_UP = "sign_up"
  SIGN_IN = "sign_in"
  DESTINATION_PARAMS_KEY = :destination
  DESTINATION_SESSION_KEY = "oauth.destination"
  ORIGIN_PARAMS_KEY = :origin
  ORIGIN_SESSION_KEY = "oauth.origin"

  class_methods do
    def provider(model)
      @provider = model
    end
  end

  included do
    before_action :store_origin, only: :create
    before_action :store_destination, only: :create
    before_action :validate_state_token, only: :show
    rescue_from ActionController::InvalidAuthenticityToken do |exception|
      redirect_to root_path, alert: "Authentication with #{provider_label} failed: invalid state token"
    end
    rescue_from ActionController::ParameterMissing do |exception|
      redirect_to root_path, alert: "Authentication with #{provider_label} failed: invalid code token"
    end
  end

  def create
    redirect_to authorization_url, allow_other_host: true
  end

  def show
    access_credentials = request_access_credentials!
    user_info = request_user_info!(access_token: access_credentials.access_token)
    auth_info = {
      "provider" => provider_key,
      "uid" => user_info.id,
      "credentials" => access_credentials.parsed_body.as_json["table"],
      "info" => user_info.parsed_body.as_json["table"]
    }

    if auth_info.any?
      authorization_succeeded auth_info
    else
      authorization_failed
    end
  rescue ApplicationClient::Error => error
    error_response = JSON.parse(error.message, symbolize_names: true)

    redirect_back fallback_location: root_path,
      alert: error_response[:message]
  end

  private

    # If the request includes an `origin` param, the app may want to use this
    # to change behavior after users complete the full OAuth flow. So store it
    # in the session for later use.
    def store_origin
      return unless params.key?(ORIGIN_PARAMS_KEY)

      session[ORIGIN_SESSION_KEY] = params[ORIGIN_PARAMS_KEY]
    end

    # If the request includes a `destination` param, the app may want to use
    # this as the location to redirect users to after they complete the full
    # OAuth flow. So store it in the session for later use.
    def store_destination
      return unless params.key?(DESTINATION_PARAMS_KEY)

      session[DESTINATION_SESSION_KEY] = params[DESTINATION_PARAMS_KEY]
    end

    def validate_state_token
      state_token = params.fetch(:state, nil)
      unless valid_authenticity_token?(session, state_token)
        raise ActionController::InvalidAuthenticityToken, "The state=#{state_token} token is inauthentic."
      end
    end

    # Generates the OAuth authorization URL that will redirect the user to the OAuth provider.
    def authorization_url
      uri = authorize_url
      uri.query = Rack::Utils.build_query({
        client_id: client_id,
        redirect_uri: callback_url,
        response_type: "code",
        scope: scope,
        state: form_authenticity_token # prevent CSRF
      })
      uri.to_s
    end

    # Requests an OAuth access token from the OAuth provider. The access token is used for subsequent
    # requests to gather information like a users name, email, address, or whatever other information
    # The OAuth provider makes available.
    def request_access_credentials!
      client = ApplicationClient.new
      client.post(token_url, body: {
        client_id: client_id,
        client_secret: client_secret,
        code: params.fetch(:code),
        grant_type: "authorization_code",
        redirect_uri: callback_url
      })
    end

    def request_user_info!(access_token:)
      client = ApplicationClient.new(token: access_token)
      client.get(user_info_url)
    end

    # The URL the OAuth provider will redirect the user back to after authenticating.
    def callback_url
      url_for(action: :show, only_path: false)
    end

    # These methods can be overriden in the host controller, if needed
    def provider_key = self.class.instance_variable_get(:@provider).key
    def provider_label = self.class.instance_variable_get(:@provider).label
    def authorize_url = self.class.instance_variable_get(:@provider).authorize_url
    def token_url = self.class.instance_variable_get(:@provider).token_url
    def user_info_url = self.class.instance_variable_get(:@provider).user_info_url
    def client_id = self.class.instance_variable_get(:@provider).client_id
    def client_secret = self.class.instance_variable_get(:@provider).client_secret
    def scope = self.class.instance_variable_get(:@provider).scopes
    def after_oauth_path = session.delete(DESTINATION_SESSION_KEY) || root_path
    def oauth_origin = session.delete(ORIGIN_SESSION_KEY)
end
