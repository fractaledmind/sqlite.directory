ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def authenticate(user:)
      session = user.sessions.create!(user_agent: "TEST", ip_address: "1234567890")
      Current.session = session
      cookie_jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      cookie_jar.signed.permanent[Session::COOKIE_KEY] = {
        value: session.encoded_id,
        httponly: true,
        secure: false
      }
      cookies[Session::COOKIE_KEY] = cookie_jar[Session::COOKIE_KEY]
    end
  end
end
