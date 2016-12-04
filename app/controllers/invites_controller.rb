class InvitesController < ApplicationController
  layout 'webview'
  before_action :load_user, only: [:new, :upcoming]

  def new
  end

  def upcoming
  end

  def respond
    render 'respond', layout: 'webview_no_menu'
  end

  def create_invite
    
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
end