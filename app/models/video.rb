class Video < ApplicationRecord
  require "cloudinary"

  belongs_to :user
  has_many :invitations

  attr_accessor :upload_file
  validates :title, presence: true
  validates :upload_file, presence: true, on: :create

  before_create :upload_to_cloudinary

  def upload_to_cloudinary
    return unless upload_file

    uploaded = Cloudinary::Uploader.upload(upload_file.path, resource_type: :video)
    self.file_url = uploaded["secure_url"]
  end
end
