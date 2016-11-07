class MessageSender < AbstractSender

  def set_message(message, data_hash={})
    @data = {
      message: {
        text: message.is_a?(Symbol) ? I18n.t(message, data_hash) : message
      }
    }
  end

end
