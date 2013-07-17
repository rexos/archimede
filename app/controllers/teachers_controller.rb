class TeachersController < ApplicationController

  def signup
  end

  def create
    @teacher = Teacher.new( params[:teacher] )
    if @teacher.save
      render action: :signup, :notice => "User correctly created"
    else
      render action: :signup, :notice => "User correctly created"
    end
  end

end
