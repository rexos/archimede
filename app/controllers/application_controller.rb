class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.find_by_token(cookies[:token]) if !cookies[:token].nil?
    end
  end

end
