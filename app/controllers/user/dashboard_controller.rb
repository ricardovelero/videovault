class User::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_regular_user!

  def index
    @recent_invitations = current_user.invitations.order(created_at: :desc).limit(5)
    @videos = Video.all.limit(3)
  end

  def ensure_regular_user!
    redirect_to root_path, alert: "Not authorized" unless current_user&.user?
  end
end
