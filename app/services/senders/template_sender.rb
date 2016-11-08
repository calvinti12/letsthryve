class TemplateSender < AbstractSender

  # How to use:
  # template = TemplateSender.new(recipient)
  # template.add_element(title: 'Invite a friend!', image_url: 'http...')
  #         .add_url_button(title: 'Invite!', url: 'http...', webview_size: 'tall')
  #         .add_share_button
  # template.add_element(...)
  # template.deliver!

  def initialize(recipient)
    super(recipient)
    @elements = []
  end

  def add_element(title: nil, subtitle: nil, item_url: nil, image_url: nil)
    raise StandardError('TemplateSender title not set') unless title

    element = {}
    element[:title] = title
    element[:subtitle] = subtitle if subtitle
    element[:item_url] = item_url if item_url
    element[:image_url] = image_url if image_url
    @elements.append(element)

    def element.add_url_button(title: nil, url: nil, webview_size: nil,
                               use_extensions: false, fallback_url: nil)
      raise StandardError('TemplateSender url button for element missing title or url') unless title && url
      raise StandardError("TemplateSender invalid value #{webview_size} for webview_size") unless [nil, 'compact', 'tall', 'full'].include?(webview_size)

      self[:buttons] = [] unless self[:buttons]
      self[:buttons].append({
        type: 'web_url',
        title: title,
        url: url,
        webview_height_ratio: webview_size,
        messenger_extensions: use_extensions,
        fallback_url: fallback_url
      })
      self
    end

    def element.add_postback_button(title: nil, payload: nil)
      raise StandardError('TemplateSender postback button for element missing title or payload') unless title && payload
      self[:buttons] = [] unless self[:buttons]
      self[:buttons].append({
        type: 'postback',
        title: title,
        payload: payload
      })
      self
    end

    def element.add_share_button
      self[:buttons] = [] unless self[:buttons]
      self[:buttons].append({
        type: 'element_share'
      })
      self
    end

    element
  end

  def deliver
    @data = {
      recipient: {id: @sender_id},
      message: {
        attachment: {
          type: "template",
          payload: {
            template_type: "generic",
            elements: @elements
          }
        }
      }
    }
    super
  end
end