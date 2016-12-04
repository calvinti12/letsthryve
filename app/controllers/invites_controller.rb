class InvitesController < ApplicationController
  layout 'webview'
  before_action :load_current_user, except: [:new, :respond]

  def new
    load_fb_user('/invites/new')
  end

  def upcoming
  end

  def respond
    load_new_fb_user('/invites/respond')
    render 'respond', layout: 'webview_no_menu'
  end

  def accept

  end

  def decline

  end

  def create_invite
    
  end

  private

  def load_invite_user(route)
    data = Rack::Utils.parse_nested_query(params[:state]).deep_symbolize_keys
    @invite = data[:invite_id]
    fb_service = FacebookProfileService.new(nil, params[:code], route)
    @current_user = fb_service.update_profile
    session[:current_user] = @current_user.id
  end

end