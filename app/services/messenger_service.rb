class MessengerService
  RANDOM_NAME = ['Bob', 'Sally', 'Rock', 'Gemmy']

  def initialize(sender_id, input)
    @sender_id = sender_id
    @input = input
    RestClient.log =
      Object.new.tap do |proxy|
        def proxy.<<(message)
          Rails.logger.info message
        end
      end
  end

  def route_incoming
    send_generic_template(:free_the_uc_stones, {random_name: RANDOM_NAME.sample})
  end

  private
  def send_generic_template(message, data_hash={})
    data = {
        recipient: {id: @sender_id},
        message: {attachment: { type: "template",
                                payload: {template_type: "generic"},
                                          elements: [{title: "Activities",
                                          item_url: "https://google.com",
                                          image_url: "http://stockfresh.com/files/l/lenm/m/83/1778303_stock-photo-family-exercise.jpg", 
                                          subtitle: "A subtitle thing",
                                          buttons: [{type: "element_share"}]
                                        }]
                              }
                  }
    }.to_json
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    data, content_type: :json
  end

  def send_message(message, data_hash={})
    data = {
        recipient: {id: @sender_id},
        message: {text: I18n.t(message, data_hash)}
    }.to_json
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    data, content_type: :json
  end

end