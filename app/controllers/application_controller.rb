class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  before_filter :logged_in?, :only => :show

  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user = Teacher.find( session[:user_id] ) if session[:user_id].to_i.odd?
      @current_user = Student.find( session[:user_id] ) if session[:user_id].to_i.even?
      @current_user
    else
      if cookies[:token]
        @current_user = Teacher.find_by_token( cookies[:token] )
        @current_user = Student.find_by_token( cookies[:token] ) if @current_user.nil?
        @current_user
      end
    end
  end

  def logged_in?
    redirect_to root_url unless current_user
  end

end
