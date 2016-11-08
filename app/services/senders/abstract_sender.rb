class AbstractSender
  SITE_DOMAIN = 'https://letsthryve.com'

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
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}",
                    request, content_type: :json
  end

  def self.url_for_asset(media)
    if media.strip =~ /\Ahttps?:\/\//
      media.strip
    else
      SITE_DOMAIN + ActionController::Base.helpers.asset_url(media.strip)
    end
  end

  def self.url_for_page(page)
    page = page.strip
    if page =~ /\Ahttps?:\/\//
      page
    elsif page =~ /\Awww\./
      'https://' + page
    elsif page =~ /\A\//
      SITE_DOMAIN + page
    else
      SITE_DOMAIN + '/' + page
    end
  end

end
