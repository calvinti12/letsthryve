class PromptSender < AbstractSender

  # How to use:
  # sender = PromptSender.new(recipient)
  # sender.set_message('Hi mom')
  # sender.add_url_button(title: 'Click me', url: 'https://google.com', ...)
  # sender.add_share_button
  # sender.deliver!

  def initialize(recipient)
    super(recipient)
    @message = nil
    @buttons = []
  end

  def set_message(message, data_hash={})
    @message = message.is_a?(Symbol) ? I18n.t(message, data_hash) : message
  end

  def add_url_button(title: nil, url: nil, webview_size: nil,
                     use_extensions: false, fallback_url: nil)
    raise StandardError('PromptSender url button for element missing title or url') unless title && url
    raise StandardError("PromptSender invalid value #{webview_size} for webview_size") unless [nil, 'compact', 'tall', 'full'].include?(webview_size)

    button = {
      type: 'web_url',
      title: title,
      url: AbstractSender.url_for_page(url)
    }
    button[:webview_height_ratio] = webview_size if webview_size
    button[:messenger_extensions] = use_extensions if use_extensions
    button[:fallback_url] = AbstractSender.url_for_page(fallback_url) if fallback_url
    @buttons.append(button)
    self
  end

  def add_postback_button(title: nil, payload: nil)
    raise StandardError('PromptSender postback button missing title or payload') unless title && payload
    @buttons.append({
      type: 'postback',
      title: title,
      payload: payload
    })
    self
  end

  def add_share_button
    @buttons.append({
      type: 'element_share'
    })
    self
  end

  def deliver
    raise StandardError('PromptSender message not set') unless @message
    raise StandardError('PromptSender buttons not set properly') unless 0 < @buttons.size && @buttons.size <= 3

    @data = {
      recipient: {id: @sender_id},
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: @message,
            buttons: @buttons
          }
        }
      }
    }
    super
  end
end