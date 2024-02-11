module UsersHelper
  def user_avatar_url(user, size: nil)
    return user.avatar_url if size.nil?

    uri = URI.parse(user.avatar_url)
    new_query_ar = URI.decode_www_form(uri.query || "") << [ "s", size ]
    uri.query = URI.encode_www_form(new_query_ar)

    uri.to_s
  end
end
