class InvitationMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def invite(invitation)
    @invitation = invitation
    @video = invitation.video
    mail(to: @invitation.email, from: "info@solucionesio.es", subject: "You have recieved an invitation to view a video")
  end
end
