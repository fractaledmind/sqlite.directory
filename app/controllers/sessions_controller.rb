class SessionsController < ApplicationController
  before_action :set_and_authorize_session, only: %i[ destroy ]

  # DELETE /sessions/1
  def destroy
    @session.destroy!
    redirect_to root_path, notice: "You are successfully logged out."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_session
      @session = Current.user.sessions.find(params[:id])
    end
end
