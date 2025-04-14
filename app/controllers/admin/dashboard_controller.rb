class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @videos = current_user.videos.order(created_at: :desc).limit(5)
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end
end
