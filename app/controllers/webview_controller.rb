class WebviewController < ApplicationController

  def login
    @sender_id = params[:sender_id]
  end

end