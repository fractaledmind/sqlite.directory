class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    render layout: "authentication"
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :avatar_url)
    end
end
