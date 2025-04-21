class Video < ApplicationRecord
  require "cloudinary"

  belongs_to :user
  has_many :invitations, dependent: :destroy

  attr_accessor :upload_file
  validates :title, presence: true
  validates :upload_file, presence: true, on: :create

  after_create_commit :enqueue_upload_job

  def enqueue_upload_job
    return unless upload_file

    tmp_path = Rails.root.join("tmp", "#{SecureRandom.uuid}_#{upload_file.original_filename}")
    File.open(tmp_path, "wb") { |f| f.write(upload_file.read) }

    UploadToCloudinaryJob.perform_later(id, tmp_path.to_s)
  end
end
