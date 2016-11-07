class MediaSender < AbstractSender
  SITE_DOMAIN = 'https://letsthryve.com'

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

    payload_url = (media.strip =~ /\Ahttps?:\/\//) ? media : url_for_asset(media)

    @data = {
      message: {
        attachment: {
          type: type,
          payload: {url: payload_url}
        }
      }
    }
  end

  def url_for_asset(filename)
    SITE_DOMAIN + ActionController::Base.helpers.asset_url(filename)
  end
end