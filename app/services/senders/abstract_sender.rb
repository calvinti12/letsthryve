class AbstractSender

  def initialize(recipient)
    raise StandardError('Recipient not set for AbstractSender') unless recipient
    @recipient = recipient
    @data = nil
  end

  def deliver!
    deliver
  end

  def deliver
    raise StandardError('Data not set for AbstractSender') unless @data

    @data.merge(recipient: {id: @sender_id})
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    @data.to_json, content_type: :json
  end

end
