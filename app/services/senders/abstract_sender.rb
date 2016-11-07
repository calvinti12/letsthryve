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

    request = @data.merge(recipient: {id: @recipient}).to_json
    Rails.logger.error "================================\n"
    Rails.logger.error request.to_s
    Rails.logger.error "==========================\n"
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    request, content_type: :json
  end

end
