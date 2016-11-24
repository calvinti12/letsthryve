class GetStartedReceiver < AbstractReceiver

  def intro_and_request_permissions
    sender = MessageSender.new(@user)
    sender.set_message('Hi, how are you, I need your permissions!')
          .add_reply(title: 'Ok!',
                     payload: link_receiver(self, :ping, {count: 1}))
          .add_reply(title: 'No!',
                     payload: link_receiver(self, :ping, {count: 1}))
          .deliver!
  end


end