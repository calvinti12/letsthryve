class MessagesController < ApplicationController

  def webhook
    if params['hub.mode'] == 'subscribe' &&
         params['hub.verify_token'] == ENV['FACEBOOK_MESSENGER_VERIFY_TOKEN']
      render text: params['hub.challenge']
    else
      head :forbidden
    end
  end

  def incoming
    if params['object'] == 'page'
      params['entry'].each do |entry|
        entry['messaging'].each do |item|
          if item['optin']
            route_optin(item)
          elsif item['postback']
            route_postback(item)
          elsif item['message'] && item['message']['quick_reply']
            route_postback(item, item['message']['quick_reply']['payload'])
          elsif item['message']
            route_text_message(item)
          end
        end
      end
    end
    head :ok
  end

  private

  def route_text_message(item)
    user = item['sender']['id']
    text = item['message']['text']
    receiver = GetStartedReceiver.new(user, {text: text})
    receiver.get_started
  end

  def route_postback(item, payload=nil)
    user = item['sender']['id']
    payload = item['postback']['payload'] if payload.nil?
    payload = JSON.parse(payload).deep_symbolize_keys
    receiver = Object.const_get(payload[:receiver]).new(user, payload[:data])
    receiver.send(payload[:method].to_sym)
  end

  def route_optin(item)
    user = item['sender']['id']
    payload = item['optin']['ref']
    sender = MessageSender.new(user)
    sender.set_message("You did the optin! Wow! #{payload}")
    sender.deliver!
  end
end
