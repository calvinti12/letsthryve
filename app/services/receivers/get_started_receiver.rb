class GetStartedReceiver < AbstractReceiver

  # Catches when the user presses the get started button
  def get_started
    intro_and_request_permissions
  end

  def intro_and_request_permissions
    multi_message do
      MessageSender.new(@user).set_message(:introduction_part_1).deliver!
      PromptSender
        .new(@user)
        .set_message(:introduction_part_2)
        .add_url_button(title: 'Ok',
                        url: with_fb_login('/login_success', {m_id: @user.fb_messenger_id}),
                        webview_size: 'tall',
                        use_extensions: true)
        .deliver!
    end
  end

  def initial_preferences
    multi_message do
      MessageSender
        .new(@user)
        .set_message(:fb_setup_complete, name: @user.first_name, friends_count: @user.friends.count)
        .deliver!

      PromptSender
        .new(@user)
        .set_message(:see_whats_happening)
        .add_url_button(title: 'What\'s Happening',
                        url: with_fb_login('/newsfeed', {m_id: @user.fb_messenger_id}),
                        webview_size: 'full',
                        use_extensions: true)
        .add_url_button(title: 'New Invite',
                        url: with_fb_login('/invites/new', {m_id: @user.fb_messenger_id}),
                        webview_size: 'full',
                        use_extensions: true)
        .deliver!

      sender = CardSender.new(@user)
      sender.add_card(title: 'Invitation: Running. Dec 12 @ 9pm - Schenely Park',
                      subtitle: 'This is the details of the event, it is important to read the details',
                      image_url: 'thryve.png')
            .add_url_button(url: with_fb_login('/invites/respond', {invite_id: 1}),
                            webview_size: 'tall', as_default_action: true)
            .add_share_button
      sender.deliver!
    end
  end

end