class SettingsReceiver < AbstractReceiver

  def modify_settings
    sender = MessageSender.new(@user)
    sender.set_message('You clicked lets go!').deliver!
  end

  def modify_later
    sender = MessageSender.new(@user)
    sender.set_message(:settings_modify_later)
          .add_reply(title: 'Got it!',
                     payload: link_receiver(ActivityReceiver, :choose_an_activity))
          .deliver
  end

end