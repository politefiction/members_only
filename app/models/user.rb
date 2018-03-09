class User < ApplicationRecord
    attr_accessor :remember_token
    before_create do 
        self.remember_token = User.new_token
        self.remember_digest = User.digest(remember_token)
    end
    before_save { self.email.downcase }

    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }
    has_secure_password
    has_many :posts

    def User.digest(string)
        Digest::SHA1.hexdigest(string)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        update_attribute(:remember_token, User.new_token)
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        User.digest(remember_token) == self.remember_digest ? true : false
        #BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end
