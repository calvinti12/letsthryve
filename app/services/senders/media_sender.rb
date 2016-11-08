class MediaSender < AbstractSender

  def set_image(image)
    set_media('image', image)
  end

  def set_audio(audio)
    set_media('audio', audio)
  end

  def set_video(video)
    set_media('video', video)
  end

  def set_file(file)
    set_media('file', file)
  end

  private

  def set_media(type, media)
    raise StandardError('Media not set for MediaSender') unless media

    @data = {
      message: {
        attachment: {
          type: type,
          payload: {url: AbstractSender.url_for_asset(media)}
        }
      }
    }
  end

end