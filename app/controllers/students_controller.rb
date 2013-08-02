class StudentsController < ApplicationController

  def create
    @address = Address.new( :street => params[:student][:street], :cap => params[:student][:cap], :country => params[:student][:country], :number => params[:student][:number] )
    @address.city = params[:student][:city]
    @address.province = params[:student][:province]
    sanitize_params :student
    @student = Student.new( params[:student] )
    if @student.save
      @student.address = @address
      render :text => "Ok Student correctly saved"
    else
      render :text => "Something went wrong"
    end
  end

  def index
    @students = Student.all
  end

  def show
  end

  def search_teacher
    words = params[:search][:text].split(' ')
    @matching = []
    for w in words
      @teachers = Teacher.find( :all, :conditions => ["name LIKE ?", "%#{w}%"] )
      if @teachers
        @teachers.each do |t|
          @matching << t unless @matching.include? t
        end
      end
    end
    respond_to do |format|
      format.js { render :action => :matching_teachers }
    end
  end

  def destroy
    @student = Student.find( params[:student_id] )
    if @student.destroy
      render :text => "Student Destroyed"
    else
      render :text => "Student not Destroyed"
    end
  end

end
