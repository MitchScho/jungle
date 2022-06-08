class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true, length: { minimum: 4 }

  def authenticate_with_credentials(email, password)
    # Find user by email with all lower case and white space stripped
    user = User.find_by_email(email.downcase.strip)
    
    # If user and user has secure password return user else nil
    user && user.authenticate(password) ? user : nil
  end
end
