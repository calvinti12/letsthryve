class MessengerService
  RANDOM_NAME = ['Bob', 'Sally', 'Rock', 'Gemmy']

  def initialize(sender_id, input)
    @sender_id = sender_id
    @input = input
  end

  def route_incoming
    send_message(:free_the_uc_stones, {random_name: RANDOM_NAME.sample})
  end

  private

  def send_message(message, data_hash={})
    data = {
        recipient: {id: @sender_id},
        message: {text: I18n.t(message, data_hash)}
    }.to_json
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    data, content_type: :json
  end

end