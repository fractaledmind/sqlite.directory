class UsersController < ApplicationController
  skip_before_action :ensure_user_authenticated!, only: %i[show]
  before_action :user_authenticated?, only: %i[show]

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end
end
