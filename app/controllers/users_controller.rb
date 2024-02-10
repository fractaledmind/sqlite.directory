class UsersController < ApplicationController
  # GET /users/1
  def show
    @user = User.find(params[:id])
  end
end
