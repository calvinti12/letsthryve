class MessageSender < AbstractSender

  # How to use:
  # To send just a message:
  # sender = MessageSender.new(user)
  # sender.set_message('Hi mom')
  #       .deliver!
  #
  # To send a message with quick replies:
  # sender = MessageSender.new(user)
  # sender.set_message('Pick one')
  #       .add_reply(title: 'exercise', payload: 'one')
  #       .add_reply(title: 'study', payload: 'two')
  #       .add_reply(title: 'eat', payload: 'three')
  #       .deliver!

  def initialize(user)
    super(user)
    @message = nil
    @replies = []
  end

  def set_message(message, data_hash={})
    @message = AbstractSender.locale_message(message, data_hash)
    self
  end

  def add_reply(title: nil, payload: nil, image_url: nil)
    raise StandardError('MessageSender reply element missing title or payload') unless title && payload
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
    raise StandardError('MessageSender message not set') unless @message
    raise StandardError('MessageSender replies not set properly') unless @replies.size <= 10

    @data = {
      message: {
        text: @message
      }
    }
    @data[:message][:quick_replies] = @replies if @replies.any?
    super
  end
end
