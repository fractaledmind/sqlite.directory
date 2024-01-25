class SessionsController < ApplicationController
  # GET /sessions/new
  def new
    @session = Session.new
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)

    if @session.save
      redirect_to @session.user, notice: "Session was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:session).permit(:user_id, :user_agent, :ip_address)
    end
end
