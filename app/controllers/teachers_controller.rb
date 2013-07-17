class TeachersController < ApplicationController

  def signup
  end

  def create
    @teacher = Teacher.new( params[:teacher] )
    if @teacher.save
      render action: :signup, flash[:notice] => "User correctly created"
    else
      render action: :signup, flash[:notice] => "User not correctly created"
    end
  end

end
