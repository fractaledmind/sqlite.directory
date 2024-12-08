class ApplicationController < ActionController::Base
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

  def filter(relation)
    return relation unless filter_params.any?

    relation.where(filter_params)
  end

  def filter_params
    params.fetch(:filter, {}).to_unsafe_hash.compact_blank
  end
end
