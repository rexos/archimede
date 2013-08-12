class AdminsController < ApplicationController
  before_filter :is_admin?

  def teachers_index
    @teachers = Teacher.all
  end

  def students_index
    @students = Student.find( :all, :conditions => ["admin = ?", false] )\
  end

  def show
  end

  def destroy_notification
    Notification.destroy( params[:notification_id] )
    redirect_to :action => :show
  end

end
