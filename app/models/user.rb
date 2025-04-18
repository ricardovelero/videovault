class User < ApplicationRecord
  has_many :videos
  has_many :invitations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, 'valid_email_2/email': { mx: true }

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end
end
