class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  protected

  def load_oauth_data
    return {} unless params[:state]
    Rack::Utils.parse_nested_query(params[:state]).deep_symbolize_keys
  end
end
