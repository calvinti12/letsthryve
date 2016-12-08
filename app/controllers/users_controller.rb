class UsersController < ApplicationController
  layout 'webview'
  before_action :load_current_user, except: [:login_success, :newsfeed]
  before_action :load_user, only: [:activity, :goals, :interests, :availability]

  def login_success
    load_fb_user('/login_success', true)
    receiver = GetStartedReceiver.new(@current_user)
    receiver.initial_preferences
    render 'login_success', layout: 'bare'
  end

  def newsfeed
    load_fb_user('/newsfeed')
    @show_all = true if params[:show_all]
    if @show_all
      @activities = Activity.except_user(@current_user).chronological
    else
      @activities = Activity.for_user_friends(@current_user).chronological
    end
  end

  def friends
    @friends = @current_user.friends.order(:full_name)
  end

  def activity
    @activities = Activity.for_user(@user).chronological
  end

  def goals
    @goals = Goal.for_user(@user).by_state.chronological
  end

  def new_goal
    Goal.create({user: @current_user, text: params[:goalText], state: 3})
    Activity.create({user: @current_user,
                     text: "#{@current_user.first_name} made a goal: #{truncate(params[:goalText], length: 70, separator: ' ')}",
                     time: now_string})
    redirect_to user_goals_url(@current_user)
  end

  def encourage
    @goal = Goal.find(params[:goal_id])
    GoalEncouragement.create({user: @current_user, goal: @goal, text: params[:message]})
    Activity.create({user: @goal.user, picture_url_override: @current_user.picture_url,
                     text: "#{@current_user.first_name} encouraged #{@goal.user.first_name}: #{truncate(params[:message], length: 70, separator: ' ')}",
                     time: now_string})
    redirect_to :back
  end

  def log_goal
    goal = Goal.find(params[:goal_id])
    goal.update_attributes(state: params[:state].to_i)
    action = ['didn\'t achieve their goal', 'tried to achieve their goal', 'achieved their goal!']
    Activity.create({user: @current_user,
                     text: "#{@current_user.first_name} #{action[params[:state].to_i]}: #{truncate(goal.text, length: 70, separator: ' ')}",
                     time: now_string})

    if params[:state].to_i == 0
      flash[:notice] = 'Logged! Better luck next time!'
    elsif params[:state].to_i == 1
      flash[:notice] = 'Logged! Good try, but, stick to it next time!'
    elsif params[:state].to_i == 2
      flash[:notice] = 'Logged! Nice job, keep it up!'
    end
    redirect_to user_goals_path(@current_user)
  end

  def availability
    @edit_mode = false
    if @user.availability.present?
      @availability = JSON.parse(@user.availability).map(&:symbolize_keys)
    else
      @availability = []
    end
  end

  def edit_availability
    @edit_mode = true
    render 'availability'
  end

  def set_availability
    availability = []
    (0...5).each do |i|
      availability.append({day: params[:free_day][i], time: params[:free_time][i]})
    end

    if params[:free_day].include?('') || params[:free_time].include?('')
      flash[:error] = 'Please set the top 5 times you\'re free'
      @edit_mode = true
      render 'availability'
    else
      @current_user.update_attributes(availability: availability.to_json)
      flash[:notice] = 'Your availability was saved'
      redirect_to user_availability_url(@current_user)
    end
  end

  def interests
    @edit_mode = false
    if @user.interests.present?
      @interests = JSON.parse(@user.interests).symbolize_keys
    else
      @interests = {exercises: ['None selected'], hangouts: ['None selected'], oncampus: ['None selected']}
    end
  end

  def edit_interests
    @edit_mode = true
    render 'interests'
  end

  def set_interests
    interests = {
      exercises: params[:exercises],
      hangouts: params[:hangouts],
      oncampus: params[:oncampus]
    }.to_json

    unless params[:exercises] && params[:hangouts] && params[:oncampus]
      flash[:error] = "Select at least one interest in each category."
      @edit_mode = true
      render 'interests'
    else
      @current_user.update_attributes(interests: interests)
      flash[:notice] = 'Your interests were saved'
      redirect_to user_interests_url(@current_user)
    end
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def now_string
    DateTime.now.strftime('On %b %e, %Y')
  end
end