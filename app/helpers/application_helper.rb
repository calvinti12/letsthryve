module ApplicationHelper

  def ampm(hour)
    Time.parse("#{hour}:00").strftime("%l%P")
  end

end
