class MessengerService
  RANDOM_NAME = ['Bob', 'Sally', 'Rock', 'Gemmy']

  def initialize(sender_id, input)
    @sender_id = sender_id
    @input = input
  end

  def route_incoming(doit)
    if doit
      send_generic_template
    else
      send_message(:free_the_uc_stones, {random_name: RANDOM_NAME.sample})
    end
  end

  private
  def send_generic_template
    data = {
        recipient: {id: @sender_id},
        message: {attachment: { type: "template",
                                payload: {template_type: "generic",
                                          elements: [{title: "Activities",
                                                      item_url: "https://google.com",
                                                      image_url: "http://stockfresh.com/files/l/lenm/m/83/1778303_stock-photo-family-exercise.jpg", 
                                                      subtitle: "A subtitle thing",
                                                      buttons: [{type: "element_share"},
                                                      {
                                                        "type":"postback",
                                                        "title":"Start Chatting",
                                                        "payload":"ISRAELS_SPECIFIC_PAYLOAD"
                                                      },{
        "type":"web_url",
        "url":"https://isitchristmas.com/",
        "title":"Christmas",
        "webview_height_ratio": "compact"
      }
                                                      ]
                                                    }]
                                }
                              }
                  }
    }.to_json
    response = RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    data, content_type: :json
  rescue
    Rails.logger.error("==========================================")
    Rails.logger.error(response)
    Rails.logger.error(response.body)
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