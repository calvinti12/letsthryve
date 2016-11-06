class SendMessageService

  def initialize(sender_id)
    @sender_id = sender_id
  end

  def message(message, data_hash={})
    data = {
      recipient: {id: @sender_id},
      message: {text: I18n.t(message, data_hash)}
    }
    send_it(data)
  end

  def generic_template(elements_hash={})
    data = {
      recipient: {id: @sender_id},
      message: {
        attachment: {
          type: "template",
          payload: {
            template_type: "generic",
            elements: [
              {
                title: "Activities",
                item_url: "https://google.com",
                image_url: "http://stockfresh.com/files/l/lenm/m/83/1778303_stock-photo-family-exercise.jpg", 
                subtitle: "A subtitle thing",
                buttons: [{type: "element_share"}]
              }
            ]
          }
        }
      }
    }
    send_it(data)
  end

  private

  def send_it(data)
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    data.to_json, content_type: :json
  end

end