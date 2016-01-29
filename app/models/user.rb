class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  belongs_to :organization
  has_many :orders, dependent: :destroy

  validates :username, presence: true, length: { maximum: 50 }
  validates :organization, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

  after_create :set_admin!

  private

  def set_admin!
    User.count == 1 ? update_attribute(:admin, true) : true
  end
end
