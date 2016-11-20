class GetStartedReceiver < AbstractReceiver

  def get_started
    sender = PromptSender.new(@user)
    sender.set_message('Login with facebook!')
    sender.add_url_button(title: 'Allow permissions',
                          url: "https://www.facebook.com/v2.8/dialog/oauth?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=https://letsthryve.com/webview/login?sender_id=#{@user}",
                          webview_size: 'tall')
    sender.deliver
  end

  def ping
    count = @data[:count]
    sender = MessageSender.new(@user)
    sender.set_message("Ping! #{count}")
          .add_reply(title: 'Pong back?',
                     payload: link_receiver(self, :pong, {count: count + 1}))
          .deliver!
  end

  def pong
    count = @data[:count]
    sender = MessageSender.new(@user)
    sender.set_message("Pong! #{count}")
          .add_reply(title: 'Ping back?',
                     payload: link_receiver(self, :ping, {count: count + 1}))

    if count >= 9
      sender.add_reply(title: "Show funny image?",
                       payload: link_receiver(self, :funny_image))
    end
    sender.deliver!
  end

  def funny_image
    sender = MediaSender.new(@user)
    sender.set_image('https://media.giphy.com/media/11LtzfNXmCQQ80/giphy.gif')
          .deliver!
  end

end