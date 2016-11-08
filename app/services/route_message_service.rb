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
    sender.deliver!
  end

end