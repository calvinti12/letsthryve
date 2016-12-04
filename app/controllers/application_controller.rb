class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  protected

  def load_current_user
    @current_user = User.find_by_id(session[:current_user])
    raise 'Unable to load user. Did you pass through FB login?' unless @current_user
  end

  def load_fb_user(route)
    @current_user = User.find_by_id(session[:current_user])
    unless @current_user
      data = Rack::Utils.parse_nested_query(params[:state]).deep_symbolize_keys
      @current_user = User.find(data[:current_user])
      fb_service = FacebookProfileService.new(@current_user, params[:code], route)
      fb_service.update_profile
      session[:current_user] = @current_user.id
    end
  end

end
