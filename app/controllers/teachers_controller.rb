# -*- coding: utf-8 -*-
class TeachersController < ApplicationController

  def signup
  end

  def create
    @address = Address.new( :street => params[:teacher][:street], :cap => params[:teacher][:cap], :country => params[:teacher][:country], :number => params[:teacher][:number] )
    @address.city = params[:teacher][:city]
    @address.province = params[:teacher][:province]
    sanitize_params :teacher
    @teacher = Teacher.new( params[:teacher] )
    if @teacher.save
      render :text => "User correctly created"
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
      render :text => "Teacher Destroyed"
    else
      render :text => "Teacher Not Destroyed"
    end
  end

end
