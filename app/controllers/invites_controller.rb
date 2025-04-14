class InvitesController < ApplicationController
  def show
    @invitation = Invitation.find_by!(token: params[:token])
    @video = @invitation.video
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Invalid invitation."
  end
end
