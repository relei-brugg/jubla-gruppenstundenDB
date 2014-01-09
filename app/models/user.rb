class User < ActiveRecord::Base
  before_create :create_remember_token
  before_save {self.email = email.downcase}

  has_many :idea_ratings
  has_many :ideas

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sesitive: false}, format: {with: VALID_EMAIL_REGEX}

  validates :password, length: {minimum: 6}, if: :validate_password?

  has_secure_password

  def validate_password?
    password.present? || password_confirmation.present?
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
