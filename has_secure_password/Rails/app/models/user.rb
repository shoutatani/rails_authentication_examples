class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email,
    format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
    presence: true,
    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, confirmation: true, presence: true

  attr_accessor :remember_token

  def self.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  def renew_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def delete_remember_token
    update_attribute(:remember_digest, nil)
  end

  def has_authenticated_token?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
