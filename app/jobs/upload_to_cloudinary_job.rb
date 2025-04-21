class UploadToCloudinaryJob < ApplicationJob
  queue_as :default

  def perform(video_id, file_path)
    Rails.logger.info "[UploadToCloudinaryJob] Iniciando subida para Video ##{video_id} desde #{file_path}"
    video = Video.find(video_id)
    uploaded = Cloudinary::Uploader.upload(file_path, resource_type: :video)
    video.update(file_url: uploaded["secure_url"])
    # sleep 5
    # video.update(file_url: "https://res.cloudinary.com/drkagbdbg/video/upload/v1744963833/us859fnzevykbtviohtw.mp4")

    Rails.logger.info "[UploadToCloudinaryJob] Subida completada. URL: #{video.file_url}"

    ActionCable.server.broadcast("video_status_#{video.user_id}", { video_id: video.id, file_url: video.file_url, status: "ready" })
  rescue => e
    Rails.logger.error "[UploadToCloudinaryJob] Error durante la subida: #{e.message}"
    raise
  ensure
    if File.exist?(file_path)
      File.delete(file_path)
      Rails.logger.info "[UploadToCloudinaryJob] Archivo temporal eliminado: #{file_path}"
    end
  end
end
