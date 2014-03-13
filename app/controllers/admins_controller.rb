# -*- coding: utf-8 -*-
class AdminsController < ApplicationController
    before_filter :is_admin?
    
    
    def activate
        @teacher = Teacher.find( params[:teacher_id] )
        @teacher.update_attributes( :active => true )
        @teacher.update_attributes( :deadline => ( @teacher.updated_at + 1.year ) )
        @teacher.notification.destroy if @teacher.notification
        redirect_to :action => :show
        #render :text => "#{@teacher.name.capitalize} #{@teacher.last_name.capitalize} è stato attivato correttamente"
    end
    
    def teachers_index
        @teachers = Teacher.all
    end
    
    def students_index
        @students = Student.find( :all, :conditions => ["admin = ?", false] )\
        end
    
    def companies_index
        @companies = Company.all
    end
    
    def show
    end
    
    def new_company
    end
    
    def create_company
        @company = Company.new( params[:company] )
        unless @company.valid?
            err = "Errori: "
            @company.errors.full_messages.each do |msg|
                err.concat(msg + ", ")
            end
            flash[:company_error] = err
            redirect_to :action => :new_company
        else
            @company.save
            redirect_to :action => :companies_index
            #render :text => "Ok --- #{@company.name} #{@company.email}"
        end
    end
    
    def destroy_company
        @company = Company.find( params[:company_id] )
        if @company.destroy
            flash[:company_destroy] = "Company destroyed"
            redirect_to :action => :companies_index
        else
            flash[:company_destroy] = "Company not destroyed"
            redirect_to :action => :companies_index
        end
    end
    
    
    def destroy_notification
        Notification.destroy( params[:notification_id] )
        redirect_to :action => :show
    end
    
end
