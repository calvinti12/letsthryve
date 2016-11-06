class TemplateBuilder

  def initialize
    @elements = []
  end

  def elements
    @elements
  end

  def add_element(title, subtitle, item_url, image_url)
    element = {
        title: title,
        subtitle: subtitle,
        item_url: item_url,
        image_url: image_url,
        buttons: []
    }
    @elements.append(element)

    def element.add_url_button(bTitle, bUrl, bWebview_height)
      element[:buttons].append({
        type: 'web_url',
        title: bTitle,
        url: bUrl,
        webview_height_ratio: bWebview_height
      })
    end

    def element.add_share_button
      element[:buttons].append({
        type: 'element_share'
      })
    end

    def element.add_postback_button(bTitle, bPayload)
      element[:buttons].append({
        type: 'postback',
        title: bTitle,
        payload: bPayload
      })
    end
  end

end