class UsersController < ApplicationController
  layout 'webview'
  before_action :load_user, except: [:login_success]

  def login_success
    data = load_oauth_data
    @user = User.find(data[:user_id])
    fb_service = FacebookProfileService.new(@user, params[:code], '/users/login_success')
    fb_service.update_profile
    receiver = GetStartedReceiver.new(@user)
    receiver.initial_preferences
    render 'login_success', layout: 'bare'
  end

  def newsfeed

  end

  def friends

  end

  def activity

  end

  def goals

  end

  def new_goal

  end

  def encourage

  end

  def log_goal

  end

  def availability

  end

  def edit_availability

  end

  def set_availability

  end

  def interests

  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
end