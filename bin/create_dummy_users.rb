# encoding: utf-8
ActiveRecord::Base.transaction do 

  (1..3).each do |i|
    t = Time.now.to_i
    user = User.new(name: "Dummy User#{i}",
                    email: "user#{i}@dummy.com", 
                    password: Devise.friendly_token[0, 20])
    user.oauth_tokens.new(provider: 'facebook', uid: "#{t}") do |oauth_token|
      oauth_token.access_token = "#{t}"
    end
    user.confirm!
    user.save!
    user
  end

end