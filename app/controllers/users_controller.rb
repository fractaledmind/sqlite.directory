class UsersController < ApplicationController
  # GET /user
  def show
    @user = User.find(params[:id])
  end
end
