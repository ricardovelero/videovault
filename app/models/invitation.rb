class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :video

  before_create :generate_token

  validates :email, 'valid_email_2/email': { mx: true }

  def generate_token
    self.token ||= SecureRandom.hex(10)
  end

  def link
    Rails.application.routes.url_helpers.invite_url(token: token)
  end
end
