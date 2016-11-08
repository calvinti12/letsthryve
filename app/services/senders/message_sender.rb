class MessageSender < AbstractSender

  # How to use:
  # sender = MessageSender.new(recipient)
  # sender.set_message 'hi mom'
  #     OR
  # sender.set_message :locale_string_id (and optional data hash)
  # sender.deliver!

  def set_message(message, data_hash={})
    @data = {
      message: {
        text: message.is_a?(Symbol) ? I18n.t(message, data_hash) : message
      }
    }
  end

end
