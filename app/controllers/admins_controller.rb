# -*- coding: utf-8 -*-
class AdminsController < ApplicationController
  before_filter :is_admin?


  def activate
    @teacher = Teacher.find( params[:teacher_id] )
    @teacher.update_attributes( :active => true )
    @teacher.update_attributes( :deadline => ( @teacher.updated_at + 1.year ) )
    @teacher.notification.destroy if @teacher.notification
    render :text => "#{@teacher.name.capitalize} #{@teacher.last_name.capitalize} è stato attivato correttamente"
  end


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
