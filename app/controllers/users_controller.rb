class UsersController < ApplicationController

  def login_success
    data = load_oauth_data
    @user = User.find(data[:user_id])
    fb_service = FacebookProfileService.new(@user, params[:code], '/users/login_success')
    fb_service.update_profile
    receiver = GetStartedReceiver.new(@user)
    receiver.initial_preferences
    render 'login_success', layout: 'bare'
  end


end