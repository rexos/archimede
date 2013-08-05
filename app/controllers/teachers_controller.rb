# -*- coding: utf-8 -*-
class TeachersController < ApplicationController
  before_filter :logged_in?, :only => :index

  def signup
  end

  def complete_signup
  end

  def payment
  end

  def complete
    @sub1 = nil
    @sub2 = nil
    @sub3 = nil

    @sub1 = Subject.find(params[:teacher][:sub1]) if params[:teacher][:sub1] != ""
    @sub2 = Subject.find(params[:teacher][:sub2]) if params[:teacher][:sub2] != ""
    @sub3 = Subject.find(params[:teacher][:sub3]) if params[:teacher][:sub3] != ""

    @teacher = Teacher.find_by_token(cookies[:token])

    @teacher.subjects.push(@sub1) if @sub1 != nil and not(@teacher.subjects.include?(@sub1))
    @teacher.subjects.push(@sub2) if @sub2 != nil and not(@teacher.subjects.include?(@sub2))
    @teacher.subjects.push(@sub3) if @sub3 != nil and not(@teacher.subjects.include?(@sub3))
    sanitize_from_subjects
    @teacher.update_attributes(params[:teacher])

    render :text => @teacher.subjects.all.map { |s| [s.id, s.name] }
    #redirect_to controller: :teachers, action: :payment
  end

  def create
    @address = Address.new( :street => params[:teacher][:street], :cap => params[:teacher][:cap], :country => params[:teacher][:country], :number => params[:teacher][:number] )
    @address.city = params[:teacher][:city]
    @address.province = params[:teacher][:province]
    sanitize_params :teacher
    @bill = nil
    @bill_address = nil
    if params[:teacher][:bill_bool] == 1
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
        @teacher.bills.push( @bill )
        @bill.address = @bill_address
      end
      cookies.permanent[:token] = @teacher.token
      redirect_to controller: :teachers, action: :complete_signup
    else
      render :text => "User not correctly created"
    end
  end

  def index
    @teachers = Teacher.all
  end

  def activate
    @teacher = Teacher.find( params[:teacher_id] )
    @teacher.update_attributes( :active => true )
    render :text => "#{@teacher.name.capitalize} #{@teacher.last_name.capitalize} è stato attivato correttamente"
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
    render :text => @teacher.email + " " + @teacher.name + " " + @teacher.last_name
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

end
