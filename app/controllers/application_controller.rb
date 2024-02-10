class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :authenticate!

  def sign_in(user:)
    session = user.sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.ip
    )
    Current.session = session
    cookies.signed.permanent[Session::COOKIE_KEY] = {
      value: session.encoded_id,
      httponly: true,
      secure: !Rails.env.development?
    }
    true
  end

  def authenticate
    return true if Current.session
    cookies.clear
    reset_session

    if (session = Session.find_by_encoded_id(cookies.signed[Session::COOKIE_KEY]))
      Current.session = session
      return true
    end

    false
  end

  def authenticate!
    return true if authenticate

    redirect_to root_path
  end
end
