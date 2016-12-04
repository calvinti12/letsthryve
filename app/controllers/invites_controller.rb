class InvitesController < ApplicationController
  layout 'webview'
  before_action :load_current_user, except: [:new, :respond]

  def new
    load_fb_user('/invites/new')
  end

  def upcoming

  end

  def respond
    load_invite_user('/invites/respond')
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
    return if dev_mode?
    data = Rack::Utils.parse_nested_query(params[:state]).deep_symbolize_keys
    @invite = Invitation.find(data[:invite_id])
    fb_service = FacebookProfileService.new(nil, params[:code], route)
    @current_user = fb_service.update_profile
    session[:current_user] = @current_user.id
  end

end