class InvitesController < ApplicationController
  layout 'webview'
  before_action :load_user, only: [:new]

  def new

  end

  def respond
    render 'respond', layout: 'application'
  end

  def see_responses
    render 'see_responses', layout: 'application'
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
end