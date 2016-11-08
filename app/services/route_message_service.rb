class RouteMessageService

  def initialize(sender_id, input)
    @sender_id = sender_id
    @input = input
  end

  def route_incoming
    catch_all
  end

  private

  def catch_all
    sender = CardSender.new(@sender_id)
    sender.add_element(title: 'Test title', subtitle: 'test subtitle',
                       item_url: 'https://google.com', image_url: 'fish.png')
          .add_url_button(title: 'Google.com', url: 'https://google.com', webview_size: 'full')
          .add_share_button
    sender.add_element(title: 'Test title', subtitle: 'test subtitle',
                       item_url: 'https://google.com', image_url: 'http://i.annihil.us/u/prod/marvel/i/mg/2/00/53710b14a320b.png')
          .add_url_button(title: 'Google.com', url: 'https://google.com', webview_size: 'tall')
          .add_share_button
    sender.deliver!

    sender = MediaSender.new(@sender_id)
    sender.set_image 'israel.png'
    sender.deliver!

    sender = PromptSender.new(@sender_id)
    sender.set_message 'Hi how are you doing today? :)'
    sender.add_postback_button(title: 'I\'m good :)', payload: 'IM_GOOD_PAYLOAD')
    sender.add_postback_button(title: 'Umm not good bro...', payload: 'IM_NOT_GOOD_BRO')
    sender.add_url_button(title: 'Lets Thryve page', url: '/')
    sender.deliver!
  end

end