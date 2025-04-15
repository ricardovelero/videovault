class User::VideosController < ApplicationController
  def index
    @videos = Video.all.includes(:user)
  end

  def show
    @video = Video.find(params[:id])
  end
end
