class AbstractReceiver

  def initialize(user, data={})
    @user = user
    @data = data
  end

  protected

  def link_receiver(receiver, method, data={})
    {
      receiver: receiver.class == Class ? receiver.to_s : receiver.class.to_s,
      method: method.to_s,
      data: data
    }.to_json
  end
end