class RouteMessageService

  def initialize(sender_id, input)
    @sender_id = sender_id
    @input = input
  end

  def route_incoming
    catch_all
  end

  private

  def catch_all
    random_names = ['Ashley', 'Jeanine', 'Israel']
    sender = MessageSender.new(@sender_id)
    sender.set_message(:welcome_message, random_name:random_names.sample)
          .deliver!

    sender = CardSender.new(@sender_id)
    sender.add_card(title: 'Fun Request', subtitle: 'Do something together with a friend and earn a badge!', image_url: 'http://photos.gograph.com/thumbs/CSP/CSP036/k0366098.jpg')
          .add_postback_button(title: 'Select', payload: 'Who do you want to do it with?')
    sender.add_card(title: 'Daily Mission', subtitle: 'Challenge yourself to an activity and earn a badge!', image_url: 'http://www.clipartkid.com/images/247/billy-roundhead-who-me-clipart-secular-buddhist-association-Tabg4y-clipart.jpg')
          .add_postback_button(title: 'Select', payload: 'What do you want to do?')
    sender.add_card(title: 'View Campus Events', subtitle: 'See what\'s happening at CMU!', image_url: 'https://www.cmu.edu/homepage/images/2007/mascotStory_236x236.jpg')
          .add_postback_button(title: 'Select', payload: 'My heart is in the work!!')
    sender.deliver!
  end
end