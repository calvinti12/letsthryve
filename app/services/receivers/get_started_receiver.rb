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
                        url: with_fb_login('/users/login_success', {user_id: @user.id}),
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
                        url: "/users/#{@user.id}/newsfeed", # TODO with_fb_login redirect
                        webview_size: 'full',
                        use_extensions: true)
    end
  end

end