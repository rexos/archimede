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
      render :text => @user.address.street
    else
      render :text => "User not found!"
    end
  end

  def destroy
  end

end
