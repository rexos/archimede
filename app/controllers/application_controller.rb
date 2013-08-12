class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  include StudentsHelper

  helper_method :current_user
  helper_method :is_student?
  helper_method :is_teacher?
  helper_method :is_admin?

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

  def is_student?
    redirect_to :controller => :teachers, :action => :show unless current_user.is_a? Student
  end

  def is_teacher?
    if current_user.is_a? Student and current_user.admin
      redirect_to :controller => :admins, :action => :show
    else
      redirect_to :controller => :students, :action => :show unless current_user.is_a? Teacher
    end
  end

  def is_admin?
    redirect_to :controller => ( current_user.class.to_s + "s" ).downcase.to_sym, :action => :show if current_user.is_a? Teacher or not current_user.admin
  end

end
