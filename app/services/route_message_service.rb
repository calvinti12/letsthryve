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
    sender.set_message :free_the_uc_stones, random_name: random_names.sample
    sender.deliver!
  end

end