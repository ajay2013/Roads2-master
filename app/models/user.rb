class User < ActiveRecord::Base
  has_many :authentications
  has_many :trips
  has_many :comments

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  # Provider and uid are needed for OAuth integration
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid
  # attr_accessible :title, :body

  validate :email_taken

  def self.find_for_provider_oauth(auth, signed_in_resource = nil)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(email: auth.info.email,
                         provider: auth.provider,
                         uid: auth.uid,
                         password: Devise.friendly_token[0, 20])
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      facebook_data = session["devise.facebook_data"]
      if data = facebook_data && facebook_data["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  # Custom validation when user tries to register with
  # email already registered with OAuth provider login.
  def email_taken
    found_user = User.scoped_by_email(email).first
    if found_user && found_user[:provider]
      errors.messages[:email] = ["has already been taken. Please sign in with #{found_user[:provider]}."]
    end
  end
end
