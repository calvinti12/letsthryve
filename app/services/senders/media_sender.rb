class MediaSender < AbstractSender

  # How to use (same for set_audio/video/file, etc)
  # sender = MediaSender.new(recipient)
  # sender.set_image('https://imageurl.com/image.png')
  #        OR
  # sender.set_image('israel.png')
  #       .deliver!

  def set_image(image)
    set_media('image', image)
    self
  end

  def set_audio(audio)
    set_media('audio', audio)
    self
  end

  def set_video(video)
    set_media('video', video)
    self
  end

  def set_file(file)
    set_media('file', file)
    self
  end

  private

  def set_media(type, media, is_reusable=true)
    raise StandardError('Media not set for MediaSender') unless media

    @data = {
      message: {
        attachment: {
          type: type,
          payload: {
            url: AbstractSender.url_for_asset(media),
            is_reusable: is_reusable
          }
        }
      }
    }
  end

end