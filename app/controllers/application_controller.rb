class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

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
end
