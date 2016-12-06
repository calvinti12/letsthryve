class InvitesController < ApplicationController
  layout 'webview'
  before_action :load_current_user, except: [:new, :respond]

  def new
    load_fb_user('/invites/new')
  end

  def upcoming
    @invites = @current_user.invitations.chronological
  end

  def respond
    load_invite_user('/invites/respond')
    render 'respond', layout: 'webview_no_menu'
    @already_responded = InvitationResponse.where({user: @current_user, invitation: @invite}).any?
    unless @already_responded
      InvitationResponse.create({user: @current_user, invitation: @invite, response: 'seen'})
    end
  end

  def accept
    @invite = Invitation.find(params[:id])
    response = InvitationResponse.where(user: @current_user, invitation: @invite).first
    response.response = 'accepted'
    response.save!
    Activity.create({user: @current_user,
                     text: "#{@current_user.first_name} is going to an event: #{@invite.what}!",
                     time: @invite.when, location: @invite.where})
  end

  def decline
    @invite = Invitation.find(params[:id])
    response = InvitationResponse.where(user: @current_user, invitation: @invite).first
    response.response = 'declined'
    response.save!
  end

  def create
    unless params[:what].present? && params[:details].present? &&
           params[:where].present? && params[:when].present?
      flash[:error] = 'Please fill out all the fields'
      render 'new'
    else
      Invitation.create({user: @current_user, what: params[:what],
                         details: params[:details], where: params[:where],
                         when: params[:when]})
      Activity.create({user: @current_user,
                       text: "#{@current_user.first_name} made a new event: #{params[:what]}!",
                       time: params[:when], location: params[:where]})
      redirect_to user_friends_url
    end
  end

  private

  def load_invite_user(route)
    return if dev_mode?
    data = Rack::Utils.parse_nested_query(params[:state]).deep_symbolize_keys
    @invite = Invitation.find(data[:invite_id])
    fb_service = FacebookProfileService.new(params[:code], route)
    @current_user = fb_service.update_profile
    session[:current_user] = @current_user.id
  end

end