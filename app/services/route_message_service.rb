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
    random_names = ['Bob', 'Rock', 'Sally', 'Steve']
    sender = MessageSender.new(@sender_id)
    sender.set_message('I hope this works')
          .deliver!
    sender = MessageSender.new(@sender_id)
    sender.set_message('Pick one')
          .add_reply(title: 'exercise', payload: 'one', image_url: 'fish.png')
          .add_reply(title: 'study', payload: 'two')
          .add_reply(title: 'eat', payload: 'three')
          .deliver!
  end

end