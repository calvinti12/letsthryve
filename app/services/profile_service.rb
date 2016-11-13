class ProfileService

  # Gets some user information
  # first_name: stirng
  # last_name: string
  # profile_pic: url string
  # locale: locale string
  # timezone: GMT offset
  # gender: string
  def self.get_profile(user_id)
    url = "https://graph.facebook.com/v2.6/#{user_id}?fields=first_name,last_name,profile_pic,locale,timezone,gender&access_token=#{ENV['PAGE_ACCESS_TOKEN']}"
    response = RestClient.get url
    JSON.parse(response).deep_symbolize_keys
  end

end