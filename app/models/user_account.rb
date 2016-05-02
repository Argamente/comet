class UserAccount < ActiveRecord::Base
  before_save{self.email = email.downcase}
  before_create :encrypt_password ,:create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
      format:{ with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }

  validates :password, length: {minimum: 6 }



  def UserAccount.account_new_remember_token
    SecureRandom.urlsafe_base64
  end

  def UserAccount.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end




  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest(password)
  end

  def create_remember_token
    self.remember_token = UserAccount.encrypt(UserAccount.account_new_remember_token)
  end

end
