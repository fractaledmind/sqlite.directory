module EntriesHelper
  def entry_submitted_by(user)
    tag.span(class: "inline-flex items-center gap-1") do
      safe_join([
        tag.span("By: "),
        image_tag(user_avatar_url(user, size: 32), class: "w-4 h-4 rounded-full"),
        tag.strong do
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
        end
      ])
    end
  end
end
