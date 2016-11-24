class AbstractReceiver

  def initialize(user, data={})
    @user = user
    @data = data
  end

  protected

  def link_receiver(receiver, method, data={})
    {
      receiver: receiver.class == Class ? receiver.to_s : receiver.class.to_s,
      method: method.to_s,
      data: data
    }.to_json
  end

  def multi_message
    @user.update_attributes(ignore: true)
    yield
    @user.update_attributes(ignore: false)
  end

  def with_fb_login(redirect_route, data={})
    base_url = 'https://www.facebook.com/v2.8/dialog/oauth?'
    redirect_url = "https://letsthryve.com#{'/' unless redirect_route[0] == '/'}#{redirect_route}"
    params = {
      client_id: ENV['FB_APP_ID'],
      redirect_uri: redirect_url,
      scope: 'public_profile,user_friends',
      state: URI.encode(data.to_query)
    }
    base_url + params.to_query
  end
end