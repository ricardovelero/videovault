class User::VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_regular_user!

  def index
    @videos = Video.all.includes(:user)
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def ensure_regular_user!
    redirect_to root_path, alert: "No autorizado" unless current_user.user?
  end
end
