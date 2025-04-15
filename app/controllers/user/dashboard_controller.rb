class User::DashboardController < User::BaseController
  def index
    @invitations = current_user.invitations.includes(:video).order(created_at: :desc).limit(5)
    @videos = Video.all.limit(3)
  end
end
