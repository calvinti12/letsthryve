class MessageSender < AbstractSender
  # How to use:
  # As a message:
  # sender = MessageSender.new(recipient)
  # sender.set_message('Hi mom')
  #       .deliver!
  #
  # As a quick reply:
  # sender = MessageSender.new(recipient)
  # sender.set_message('Pick one')
  #       .add_reply(title: 'exercise', payload: 'one')
  #       .add_reply(title: 'study', payload: 'two')
  #       .add_reply(title: 'eat', payload: 'three')
  #       .deliver!
  
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
  	raise StandardError('QuickReplySender replies not set properly') unless @replies.size <= 10

  	@data = {
      recipient: {id: @sender_id},
      message: {
      	text: @message
      }
    }
    @data[:message][:quick_replies] = @replies if @replies.size > 0
    super
  end
end
