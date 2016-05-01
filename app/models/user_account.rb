class UserAccount < ActiveRecord::Base
  before_save{self.email = email.downcase}
  before_create :encrypt

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
      format:{ with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }

  #has_secure_password
  validates :password, length: {minimum: 6 }


  private
  def encrypt
    self.password = Digest::SHA1.hexdigest(password)
  end


end
