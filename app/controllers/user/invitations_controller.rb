class User::InvitationsController < User::BaseController
  def index
    @invitations = current_user.invitations.includes(:video)
  end

  def new
    @invitation = Invitation.new
    @videos = Video.all
  end

  def create
    @invitation = current_user.invitations.build(invitation_params)
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver_later
      redirect_to user_invitations_path, notice: "Invitation sent successfully. Link: #{@invitation.link}"
    else
      @videos = Video.all
      render :new
    end
  end

  def destroy
    @invitation = current_user.invitations.find(params[:id])
    @invitation.destroy
    redirect_to user_dashboard_path, notice: "Invitation deleted successfully."
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :video_id)
  end
end
