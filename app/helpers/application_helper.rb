module ApplicationHelper


  def fb_icon(user)
    user_oauth_token = user.oauth_tokens.detect { |oauth_token| oauth_token.provider == "facebook" }
    if user_oauth_token
      image_tag "https://graph.facebook.com/#{user_oauth_token.uid}/picture?type=square", alt: user.name
    else
      'no_image'
    end
  end

end
