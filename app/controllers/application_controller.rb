class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  include StudentsHelper

  helper_method :current_user
  helper_method :is_student?
  helper_method :is_teacher?

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

  def set_http_return
    session[:return] = request.url
  end

  def is_student?
    redirect_to session[:return] unless current_user.is_a? Student
  end

  def is_teacher?
    redirect_to session[:return] unless current_user.is_a? Teacher
  end

end
