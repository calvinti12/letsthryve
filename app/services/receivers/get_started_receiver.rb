class GetStartedReceiver < AbstractReceiver

  def get_started
    sender = MessageSender.new(@user)
    sender.set_message(:getting_started_greeting_1).deliver!
    sender.set_message(:getting_started_greeting_2).deliver!
    sender.set_message(:getting_started_greeting_3)
          .add_reply(title: 'Let\'s Go!',
                     payload: link_receiver(SettingsReceiver, :modify_settings))
          .add_reply(title: 'Later',
                     payload: link_receiver(SettingsReceiver, :modify_later))
          .deliver!
  end

end