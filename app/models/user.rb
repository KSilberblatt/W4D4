# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  sessions_token  :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :sessions_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats
  has_many :cat_rental_requests

  attr_reader :password

  def reset_session_token!
    self.sessions_token ||= SecureRandom::urlsafe_base64
    self.save!
    self.sessions_token
  end

  def password=(password)
    @password = password
    if @password
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def is_password?(password)
    pass_hash = BCrypt::Password.new(self.password_digest)
    pass_hash.is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

end
