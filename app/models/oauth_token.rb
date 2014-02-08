class OauthToken < ActiveRecord::Base

  belongs_to :user
  #attr_accessible :user_id, :uid, :provider, :access_token

end
