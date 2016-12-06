class AbstractSender
  SITE_DOMAIN = 'https://letsthryve.com'

  def initialize(user)
    raise StandardError('Recipient not set for AbstractSender') unless user
    @user = user
    @data = nil
  end

  def deliver!
    deliver
  end

  def deliver
    raise StandardError('Data not set for AbstractSender') unless @data

    # Gives the illusion of the bot processing the user's message.
    typing_hint_request = {recipient: {id: @user.fb_messenger_id}, sender_action: 'typing_on'}.to_json
    make_request(typing_hint_request)
    sleep 0.25

    # Sends the actual message
    message_request = @data.merge(recipient: {id: @user.fb_messenger_id}).to_json
    @user.update_attributes(last_message_sent: message_request)
    make_request(message_request)
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

  def self.locale_message(message, data_hash={})
    message.is_a?(Symbol) ? I18n.t(message, data_hash) : message
  end

  def self.repeat_last_message(user)
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['FB_PAGE_ACCESS_TOKEN']}",
                    user.last_message_sent, content_type: :json
  end

  private

  def make_request(request)
    RestClient.post "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['FB_PAGE_ACCESS_TOKEN']}",
                    request, content_type: :json
  rescue => e
    Rails.logger("\n\n=======================================RESTCLIENT")
    Rails.logger(e.response)
    Rails.logger("=============================+END")
  end

end
