# -*- coding: utf-8 -*-
class TeachersController < ApplicationController
  before_filter :logged_in?, :except => [ :signup, :complete, :complete_signup, :payment, :create ]
  before_filter :is_teacher?, :except => [ :signup, :complete, :complete_signup, :payment, :create, :visit ]

  def signup
    #if current_user.is_a? Student
    #  redirect_to controller: :students, action: :show
    #elsif current_user.is_a? Teacher
    #  redirect_to controller: :teachers, action: :show
    #else
    #end
  end

  def complete_signup
    #if current_user.is_a? Student
    #  redirect_to controller: :students, action: :show
    #elsif current_user.is_a? Teacher
    #  redirect_to controller: :teachers, action: :show
    #else
    #end
  end

  def payment
    ArchimedeMailer.confirm_mail( Student.find_by_name( "Alex" ) ).deliver
    render :text => "Payment done"
  end

  def change_password
    change_psw
  end

  def complete
    @teacher = Teacher.find_by_token(cookies[:token])
    @teacher.subjects = generate_subjects

    sanitize_from_subjects
    @teacher.update_attributes(params[:teacher])
    @teacher.notification = Notification.new( :body => "Iscrizione effettuata il #{@teacher.created_at.to_s[0...10]} alle #{@teacher.created_at.to_s[11..18]}" )
    #render :text => @teacher.subjects.all.map { |s| [s.id, s.name] }
    #redirect_to controller: :teachers, action: :payment
    redirect_to controller: :teachers, action: :show
  end

  def create
    @address = Address.new( :street => params[:teacher][:street], :cap => params[:teacher][:cap], :country => params[:teacher][:country], :number => params[:teacher][:number] )
    @address.city = params[:teacher][:city]
    @address.province = params[:teacher][:province]
    sanitize_params :teacher
    @bill = nil
    @bill_address = nil
    if params[:teacher][:bill_bool].to_i == 1
      @bill = generate_bill
      @bill_address = generate_bill_address
    end
    sanitize_from_bill
    sanitize_from_bill_address
    @teacher = Teacher.new( params[:teacher] )
    if @teacher.save
      @teacher = Teacher.find_by_email( @teacher.email )
      @teacher.address = @address
      if @bill
        @bill.address = @bill_address
        @teacher.bills.push( @bill )
      end
      cookies.permanent[:token] = @teacher.token
      redirect_to controller: :teachers, action: :complete_signup
    else
      render :text => "Teacher not correctly created"
    end
  end

  def destroy
    @teacher = Teacher.find( params[:teacher_id] )
    if @teacher.destroy
      flash[:notice] = "Docente #{@teacher.name.capitalize} #{@teacher.last_name.capitalize} Cancellato"
      redirect_to :action => :index
    else
      render :text => "Error Teacher Not Destroyed"
    end
  end

  def visit
    @teacher = Teacher.find( params[:teacher_id] )
    addresses = []
    addresses << @teacher.address
    addresses << current_user.address
    @json = addresses.to_gmaps4rails
    @range_circle = '[{"lng": "'+@teacher.address.longitude.to_s+'", "lat": "'+@teacher.address.latitude.to_s+'", "radius": '+(@teacher.range * 1000).to_s+'}]'
    session[:visited] = @teacher.id #session variable due to rating handling
    redirect_to :controller => (current_user.class.to_s + "s").downcase.to_sym, :action => :show unless @teacher.active
  end

  def update_data
    if current_user.is_a? Teacher
      @new_address = { :street => params[:teacher][:street], :number => params[:teacher][:number], :cap => params[:teacher][:cap], :country => params[:teacher][:country], :city => params[:teacher][:city], :province => params[:teacher][:province] }
      current_user.address.update_attributes( @new_address )
      sanitize_params :teacher
      current_user.update_attributes( params[:teacher] )
    end
      redirect_to :action => :show
  end

  def update_info
    if current_user.is_a? Teacher
      params[:teacher].delete( :cost_label )
      params[:teacher].delete( :range_label )
      current_user.update_attributes( params[:teacher] )
    end
      redirect_to :action => :show
  end

  def update_bill
      redirect_to :action => :show
  end

  def update_subjects
    current_user.subjects.clear
    current_user.subjects = generate_subjects
    #render :text => current_user.subjects.all.map { |s| [s.id, s.name] }
    redirect_to :action => :show
  end

  private

  def generate_bill_address
    @bill_address = Address.new( :street => params[:teacher][:bill_street], :cap => params[:teacher][:bill_cap], :country => params[:teacher][:bill_country], :number => params[:teacher][:bill_number] )
    @bill_address.city = params[:teacher][:bill_city]
    @bill_address.province = params[:teacher][:bill_province]
    @bill_address
  end

  def generate_bill
    @bill = Bill.new
    @bill.iva = params[:teacher][:iva]
    @bill.cf = params[:teacher][:cf]
    @bill.business_name = params[:teacher][:business_name]
    @bill.name = params[:teacher][:bill_name]
    @bill.last_name = params[:teacher][:bill_last_name]
    @bill
  end

  def generate_subjects
    @subjects = Array.new
    @sub1 = nil
    @sub2 = nil
    @sub3 = nil
    @sub1 = Subject.find(params[:teacher][:sub1]) if params[:teacher][:sub1] != ""
    @sub2 = Subject.find(params[:teacher][:sub2]) if params[:teacher][:sub2] != ""
    @sub3 = Subject.find(params[:teacher][:sub3]) if params[:teacher][:sub3] != ""
    @subjects.push(@sub1) if @sub1 != nil
    @subjects.push(@sub2) if @sub2 != nil
    @subjects.push(@sub3) if @sub3 != nil
    @subjects.uniq!
    @subjects
  end

end
