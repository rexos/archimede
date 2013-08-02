class SessionsController < ApplicationController

  def login
  end

  def create
    @user = Teacher.find_by_email( params[:session][:email] )
    @user = Student.find_by_email( params[:session][:email] ) unless @user
    if @user and @user.authenticate( params[:session][:password] )
      session[:user_id] = @user.id
      if params[:session][:remember].to_i == 1
        cookies.permanent[:token] = @user.token
      end
      if @user.is_a? Student
        redirect_to :controller => :students, :action => :show
      else
        render :text => @user.name.capitalize
      end
    else
      render :action => :login
    end
  end

  def destroy
    cookies.delete(:token)
    session.delete(:user_id)
    redirect_to root_url
  end

end
