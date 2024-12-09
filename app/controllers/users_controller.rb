class UsersController < ApplicationController
  skip_before_action :ensure_user_authenticated!, only: %i[show]
  before_action :user_authenticated?, only: %i[show]

  # GET /users/:slug
  def show
    @user = User.find_by!(github_username: params[:slug])
  end
end
