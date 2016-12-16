class FacebookProfileService

  def initialize(code, origin_request_route, messenger_id=nil)
    @messenger_id = messenger_id
    @access_token = generate_access_token(code, origin_request_route)
  end

  def update_profile
    profile_data = get_profile

    @user = User.where(fb_profile_id: profile_data[:id]).first
    @user = User.where(fb_messenger_id: @messenger_id).where('first_name IS NOT NULL').first if @user.nil?
    @user = User.create if @user.nil?
    @user.update_attributes({
      fb_profile_id: profile_data[:id],
      first_name: profile_data[:first_name],
      full_name: profile_data[:name],
      picture_url: profile_data[:picture][:data][:url]
    })
    @user.update_attributes(fb_messenger_id: @messenger_id) if @user.fb_messenger_id.nil? && @messenger_id.present?

    profile_data[:friends][:data].each do |friend_data|
      friend = User.where(fb_profile_id: friend_data[:id]).first
      if friend
        Friendship.find_or_create_by(user_id: @user.id, friend_id: friend.id)
      end
    end
    @user.reload
  end

  private

  def generate_access_token(code, origin_request_route)
    redirect_uri = 'https://letsthryve.com' + origin_request_route
    base_url = 'https://graph.facebook.com/v2.8/oauth/access_token?'
    params = {
      client_id: ENV['FB_APP_ID'],
      redirect_uri: redirect_uri,
      client_secret: ENV['FB_APP_SECRET'],
      code: code
    }
    result = make_request(base_url, params)
    result[:access_token]
  end

  def get_profile
    base_url = 'https://graph.facebook.com/v2.8/me?'
    params = {
      access_token: @access_token,
      fields: 'id,first_name,name,picture.type(large),friends.limit(100)'
    }
    make_request(base_url, params)
  end

  def make_request(base_url, params)
    response = RestClient.get base_url + params.to_query
    JSON.parse(response.body).deep_symbolize_keys
  end

end