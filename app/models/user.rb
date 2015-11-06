class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :username, :password, length: { in: 6..10 }

  has_many :snippets

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.password = "123456789"
      user.username = auth["info"]["name"]["avatar_url"]
    end
  end
  # has_many :favorites, dependent: :destroy
end
