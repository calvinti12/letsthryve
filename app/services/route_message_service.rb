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
    random_names = ['Bob', 'Rock', 'Sally', 'Steve']
    sender = MessageSender.new(@sender_id)
    sender.set_message :free_the_uc_stones, random_name: random_names.sample
    sender.deliver!

    sender = MediaSender.new(@sender_id)
    sender.set_image 'fish.png'
    sender.deliver!

    sender.set_image 'https://yt3.ggpht.com/-v0soe-ievYE/AAAAAAAAAAI/AAAAAAAAAAA/OixOH_h84Po/s900-c-k-no-mo-rj-c0xffffff/photo.jpg'
    sender.deliver!

    sender.set_file 'sprintreport.pdf'
    sender.deliver!

    sender.set_audio 'sampleaudio.mp3'
    sender.deliver!

    sender.set_video 'samplevid.mp4'
    sender.deliver!

  end

end