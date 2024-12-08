class GitHubOAuth
  def initialize
    @github_id = nil
    @github_username = nil
    @request = nil
  end

  def call(env)
    @request = Rack::Request.new(env)

    case [ @request.request_method, @request.path_info ]
    when [ "GET", "/developer/oauth/authorize" ]
      authorize
    when [ "GET", "/developer/oauth/authorized" ]
      authorized
    when [ "POST", "/developer/oauth/access_token" ]
      access_token
    when [ "GET", "/developer/oauth/user_info" ]
      user_info
    end
  end

  private

  def authorize
    response = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>User Info</title>
      </head>
      <body style='text-align:center;'>
        <h1>User Info</h1>
        <form method='get' action='/developer/oauth/authorized' noValidate='noValidate' style='display:flex;flex-direction:column;width:fit-content;margin:1rem auto;text-align:left;gap:1rem;'>
          <input type='hidden' name='state' value='#{@request.params["state"]}' />
          <input type='hidden' name='callback_url' value='#{@request.params["redirect_uri"]}' />

          <label for='github_id'>GitHub ID:</label>
          <input type='text' id='github_id' name='github_id' />

          <label for='github_username'>GitHub Username:</label>
          <input type='text' id='github_username' name='github_username' />

          <button type='submit'>Submit</button>
        </form>
      </body>
      </html>
    HTML

    [ 200, { "content-type" => "text/html" }, [ response ] ]
  end

  def authorized
    @github_id = @request.params["github_id"]
    @github_username = @request.params["github_username"]
    uri = URI(@request.params["callback_url"])
    uri.query = Rack::Utils.build_query({
      state: @request.params["state"],
      code: "CODE"
    })

    [ 302, { "location" => uri.to_s }, [] ]
  end

  def access_token
    response = {
      access_token: "ACCESS TOKEN"
    }.to_json
    [ 200, { "content-type" => "application/json" }, [ response ] ]
  end

  def user_info
    response = {
      id: @github_id,
      login: @github_username,
      avatar_url: "https://avatars.githubusercontent.com/u/5077225?v=4",
      twitter_username: "fractaledmind"
    }.to_json
    [ 200, { "content-type" => "application/json" }, [ response ] ]
  end
end
