module EntriesHelper
  def entry_submitted_by(user)
    safe_join([
      image_tag(user_avatar_url(user, size: 32), class: "inline-block w-4 h-4 rounded-full mb-1 mr-1"),
      if user.twitter_username.present?
        link_to "https://x.com/#{user.twitter_username}", class: "group" do
          safe_join([
            tag.i("@"),
            tag.span(user.twitter_username, class: "group-hover:underline")
          ])
        end
      elsif user.github_username.present?
        link_to "https://github.com/#{user.github_username}", class: "group" do
          safe_join([
            tag.i("@"),
            tag.span(user.github_username, class: "group-hover:underline")
          ])
        end
      else
        user.name
      end
    ])
  end
end
