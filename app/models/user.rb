class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :likes
  has_many :ratings
  has_many :comments
  has_many :orders

  validates_presence_of :name

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    unless user
      user = User.create(name: data["name"], email: data["email"],
        password: Devise.friendly_token[0,20])
    end
    user
end
end
