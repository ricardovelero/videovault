class Admin::VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @videos = current_user.videos
  end

  def new
    @video = Video.new
  end

  def create
    @video = current_user.videos.build(video_params.except(:upload_file))
    @video.upload_file = video_params[:upload_file]

    if @video.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Video is being processed..." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @video = current_user.videos.find(params[:id])
    @video.upload_file = video_params[:upload_file]
    if @video.update(video_params.except(:upload_file))
      redirect_to admin_videos_path, notice: "Title updated"
    else
      redirect_to admin_videos_path, alert: "There was a problem updating the video"
    end
  end

  def show
    @video = current_user.videos.find(params[:id])
  end

  def edit
    @video = current_user.videos.find(params[:id])
    render partial: "form_inline", locals: { video: @video, field: params[:field] }
  end

  def destroy
    @video = current_user.videos.find(params[:id])

    if @video.file_url.present?
      public_id = extract_public_id(@video.file_url)
      Cloudinary::Uploader.destroy(public_id, resource_type: :video)
    end

    @video.destroy
    redirect_to root_path, notice: "Video deleted successfully"
  end

  private

  def extract_public_id(file_url)
    uri = URI.parse(file_url)
    path = uri.path.sub(%r{^/}, "") # remove leading slash
    path.gsub(%r{^video/upload/}, "").sub(File.extname(path), "")
  end

  def video_params
    params.require(:video).permit(:title, :description, :upload_file)
  end

  def ensure_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end
end
