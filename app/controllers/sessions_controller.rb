class SessionsController < ApplicationController

  def login
    deactivate
    if current_user.is_a? Student
      if current_user.admin
        redirect_to controller: :admins, action: :show
      else
        redirect_to controller: :students, action: :show
      end
    elsif current_user.is_a? Teacher
      redirect_to controller: :teachers, action: :show
    else
    end
  end

  def create
    @user = Teacher.find_by_email( params[:session][:email] )
    @user = Student.find_by_email( params[:session][:email] ) unless @user
    if @user and @user.authenticate( params[:session][:password] )
      session[:user_id] = @user.id
      session[:role] = @user.class.to_s
      if params[:session][:remember].to_i == 1
        cookies.permanent[:token] = { :value => @user.token, :httponly => true }
      end
      if @user.is_a? Student
        if @user.admin
          redirect_to :controller => :admins, :action => :show
        else
          redirect_to :controller => :students, :action => :show
        end
      else
        redirect_to :controller => :teachers, :action => :show
      end
    else
      flash[:login_error] = "Email o password non corretti"
      render :action => :login
    end
  end

  def destroy
    cookies.delete(:token)
    session.delete(:user_id)
    redirect_to root_url
  end


  def restore_password
    @user = Teacher.find_by_email( params[:restore][:email_address] )
    @user = Student.find_by_email( params[:restore][:email_address] ) unless @user
    if @user
      new_pass = (0...8).map{(65+rand(26)).chr}.join
      @user.update_attributes( :password => new_pass, :password_confirmation => new_pass )
      ArchimedeMailer.restore_password( @user, new_pass ).deliver
      render :text => "La nuova password e' stata mandata all'indirizzo email"
    else
      render :text => "Indirizzo email errato"
    end
  end

end
