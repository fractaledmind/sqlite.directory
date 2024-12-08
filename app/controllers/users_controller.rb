class UsersController < ApplicationController
  # GET /user
  def show
    @user = Current.user
  end
end
