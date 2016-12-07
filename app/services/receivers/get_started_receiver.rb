class GetStartedReceiver < AbstractReceiver
  include ActionView::Helpers::TextHelper

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
      sender = CardSender.new(@user)
      sender.add_card(title: "See what's happening",
                      subtitle: "You have #{pluralize(@user.friends.count, 'friend')} using Let's Thryve! See what they're up to!",
                      image_url: 'whatshappening.jpg')
            .add_url_button(url: with_fb_login('/newsfeed', {m_id: @user.fb_messenger_id}),
                            webview_size: 'full', use_extensions: true, as_default_action: true)

      sender.add_card(title: "Invite a Friend",
                      subtitle: "Invite a friend to exercise, hangout, go to an event on campus, or anything!",
                      image_url: 'newinvite.png')
            .add_url_button(url: with_fb_login('/invites/new', {m_id: @user.fb_messenger_id}),
                            webview_size: 'full', use_extensions: true, as_default_action: true)
      sender.deliver!
    end
  end

  def send_invite_card(invite)
    multi_message do
      sender = CardSender.new(@user)
      sender.add_card(title: "Invitation: #{invite.what}. #{invite.when} - #{invite.where}",
                      subtitle: "#{invite.details}. Click on the image above to respond.",
                      image_url: 'thryve.png')
            .add_url_button(url: with_fb_login('/invites/respond', {invite_id: invite.id}),
                            webview_size: 'tall', as_default_action: true)
            .add_share_button
      sender.deliver!
    end
  end

end