class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  # protect_from_forgery with: :exception

  protected

  def load_current_user
    return if dev_mode?
    @current_user = User.find_by_id(session[:current_user])
    raise 'Unable to load user. Did you pass through FB login?' unless @current_user
  end

  def load_fb_user(route, force=false)
    return if dev_mode?
    @current_user = force ? nil : User.find_by_id(session[:current_user])
    unless @current_user
      data = Rack::Utils.parse_nested_query(params[:state]).deep_symbolize_keys
      fb_service = FacebookProfileService.new(params[:code], route, data[:m_id])
      @current_user = fb_service.update_profile
      session[:current_user] = @current_user.id
    end
  end

  def dev_mode?
    if Rails.env.development?
      @current_user = User.find(2)
      @invite = Invitation.first
      return true
    end
    false
  end

end
