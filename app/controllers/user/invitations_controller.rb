class User::InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_regular_user!

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

  private

  def invitation_params
    params.require(:invitation).permit(:email, :video_id)
  end

  def ensure_regular_user!
    redirect_to root_path unless current_user.user?
  end
end
