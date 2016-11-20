class ActivityReceiver < AbstractReceiver

  def choose_an_activity
    sender = MessageSender.new(@user)
    sender.set_message(:activity_choose_an_activity_start).deliver!

    sender = CardSender.new(@user)
    sender.add_card(title: :friend_challenge_title,
                    subtitle: :friend_challenge_subtitle,
                    item_url: nil, image_url: 'fish.png')
          .add_postback_button(title: 'Select',
                               payload: link_receiver(self, :select_challenge_friend))
    sender.add_card(title: :daily_mission_title,
                    subtitle: :daily_mission_subtitle,
                    item_url: nil, image_url: 'israel.png')
          .add_postback_button(title: 'Select',
                               payload: link_receiver(self, :select_daily_mission))
    sender.add_card(title: :campus_events_title,
                    subtitle: :campus_events_subtitle,
                    item_url: nil, image_url: 'Christabelle.jpg')
          .add_postback_button(title: 'Select',
                               payload: link_receiver(self, :select_see_campus_events))
    sender.deliver!
  end

  def select_challenge_friend
    sender = MessageSender.new(@user)
    sender.set_message('You chose challenge a friend :)!').deliver!
  end

  def select_daily_mission
    sender = MessageSender.new(@user)
    sender.set_message('You chose daily mission :)!').deliver!
  end

  def select_see_campus_events
    sender = MessageSender.new(@user)
    sender.set_message('You chose campus events :)!').deliver!
  end

end