class RouteMessageService

  def initialize(sender_id, input)
    @sender_id = sender_id
    @input = input
    @send_service = SendMessageService.new(@sender_id)
  end

  def route_incoming
    catch_all
  end

  private

  def catch_all
    random_names = ['Bob', 'Rock', 'Sally', 'Steve']
    @send_service.message(:free_the_uc_stones, {random_name: random_names.sample})
  end

end