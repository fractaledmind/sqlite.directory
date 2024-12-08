class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :ensure_user_authenticated!

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

  def user_authenticated?
    return true if Current.session

    if (session = Session.find_by_encoded_id(cookies.signed[Session::COOKIE_KEY]))
      Current.session = session
      return true
    end

    false
  end

  def ensure_user_authenticated!
    return true if user_authenticated?

    redirect_to root_path, alert: "You need to sign in first"
  end
end
