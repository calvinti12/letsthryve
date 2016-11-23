class MessagesController < ApplicationController

  def webhook
    if params['hub.mode'] == 'subscribe' &&
         params['hub.verify_token'] == ENV['FB_MESSENGER_VERIFY_TOKEN']
      render text: params['hub.challenge']
    else
      head :forbidden
    end
  end

  def incoming
    if params['object'] == 'page'
      params['entry'].each do |entry|
        entry['messaging'].each do |item|
          user = load_user(item['sender']['id'])
          handle_incoming_item(user, item) unless user.ignore
        end
      end
    end
    head :ok
  end

  private

  def handle_incoming_item(user, item)
    if user.fb_profile_id.nil?
      receiver = GetStartedReceiver.new(user)
      receiver.intro_and_request_permissions
    elsif item['optin']
      route_optin(user, item)
    elsif item['postback']
      route_postback(user, item)
    elsif item['message'] && item['message']['quick_reply']
      route_postback(user, item, item['message']['quick_reply']['payload'])
    elsif item['message']
      AbstractSender.repeat_last_message(user)
    end
  end

  def route_postback(user, item, payload=nil)
    payload = item['postback']['payload'] if payload.nil?
    payload = JSON.parse(payload).deep_symbolize_keys
    receiver = Object.const_get(payload[:receiver]).new(user, payload[:data])
    receiver.send(payload[:method].to_sym)
  end

  def route_optin(user, item)
    payload = item['optin']['ref']
    sender = MessageSender.new(user)
    sender.set_message("You did the optin! Wow! #{payload}")
          .deliver!
  end

  def load_user(sender_id)
    User.find_or_create_by(fb_messenger_id: sender_id)
  end
end
