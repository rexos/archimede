class StudentsController < ApplicationController

  def create
    @address = Address.new( :street => params[:student][:street], :cap => params[:student][:cap], :country => params[:student][:country], :number => params[:student][:number] )
    @address.city = params[:student][:city]
    @address.province = params[:student][:province]
    params[:student].delete( :street )
    params[:student].delete( :cap )
    params[:student].delete( :country )
    params[:student].delete( :number )
    params[:student].delete( :city )
    params[:student].delete( :province )
    @student = Student.new( params[:student] )
    if @student.save
      @student.address = @address
      render :text => "Ok Student correctly saved"
    else
      render :text => "Something went wrong"
    end
  end

end
