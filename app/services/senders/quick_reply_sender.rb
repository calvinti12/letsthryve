class QuickReplySender < AbstractSender
  def initialize(recipient)
    super(recipient)
    @message = nil
    @replies = []
  end

  def set_message(message, data_hash={})
    @message = message.is_a?(Symbol) ? I18n.t(message, data_hash) : message
    self
  end

  def add_reply(title: nil, payload: nil, image_url: nil)
  	raise StandardError('QuickReplySender reply element missing title or payload') unless title && payload
  	reply = {
  	  content_type: 'text',
  	  title: title,
  	  payload: payload
  	}
  	reply[:image_url] = AbstractSender.url_for_asset(image_url) if image_url
  	@replies.append(reply)
  	self
  end

  def deliver
  	raise StandardError('QuickReplySender message not set') unless @message
  	raise StandardError('QuickReplySender replies not set properly') unless 0 < @replies.size && @replies.size <= 10
  	@data = {
      recipient: {id: @sender_id},
      message: {
      	text: @message,
      	quick_replies: @replies
      }
    }
    super
  end
end
