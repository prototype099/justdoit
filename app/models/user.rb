class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :omniauthable

  has_many :oauth_tokens, dependent: :destroy

  def has_role?(role)
    return false unless role
    self.role == role.to_s
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    return signed_in_resource if signed_in_resource

    token = OauthToken.includes(:user).where(provider: auth.provider, uid: auth.uid).first

    if token
      token.user
    else
      user = User.new(name: auth.extra.raw_info.name,
                      email: auth.info.email, 
                      password: Devise.friendly_token[0, 20])
      user.oauth_tokens.new(provider: auth.provider, uid: auth.uid) do |oauth_token|
        oauth_token.access_token = auth.credentials.token
        oauth_token.expires_at = Time.zone.at(auth.credentials.expires_at) if auth.credentials.expires
      end
      user.confirm!
      user.save!
      user
    end

  end

end
