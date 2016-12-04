class UsersController < ApplicationController
  layout 'webview'
  before_action :load_current_user, except: [:login_success, :newsfeed]
  before_action :load_user, only: [:activity, :goals, :interests, :availability]

  def login_success
    load_fb_user('/login_success')
    receiver = GetStartedReceiver.new(@current_user)
    receiver.initial_preferences
    render 'login_success', layout: 'bare'
  end

  def newsfeed
    load_fb_user('/newsfeed')
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

  def edit_interests
    
  end

  def set_interests

  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

end