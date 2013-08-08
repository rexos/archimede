class StudentsController < ApplicationController
  before_filter :logged_in?, :except => :create
  before_filter :is_student?, :except => :create

  def create
    @address = Address.new( :street => params[:student][:street], :cap => params[:student][:cap], :country => params[:student][:country], :number => params[:student][:number] )
    @address.city = params[:student][:city]
    @address.province = params[:student][:province]
    sanitize_params :student
    @student = Student.new( params[:student] )
    if @student.save
      @student = Student.find_by_email( @student.email )
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

  def change_password
    change_psw
  end

  #search teacher method
  def search_teacher
    @matching = @teachers = []
    unless params[:search][:text].eql? ""
      words = params[:search][:text].split(' ')
      @teachers = Teacher.find( :all, :conditions => ["( name LIKE ?  OR last_name LIKE ? ) AND active = ?", "%#{words[0]}%", "%#{words[0]}%", true] )
      Address.find( :all, :conditions => ["city LIKE ?", "%#{words[0]}%"] ).each do |a|
        if a.teacher
          @teachers << a.teacher if a.teacher.active and not @teachers.include? a.teacher
        end
      end
      Teacher.find( :all, :conditions => ["active = ?", true] ).each do |t|
        unless t.subjects.empty?
          t.subjects.each do |s|
            @teachers << t if s.name.downcase.include? words[0].downcase and not @teachers.include? t
          end
        end
      end
      @matching = @teachers
      words.delete_at(0)
      for word in words
        @teachers = Teacher.find( :all, :conditions => ["( name LIKE ?  OR last_name LIKE ? ) AND active = ?", "%#{word}%", "%#{word}%", true] )
        @matching = @matching & @teachers unless @teachers.empty?
        @teachers = []
        Address.find( :all, :conditions => ["city LIKE ?", "%#{word}%"] ).each do |a|
          if a.teacher
            @teachers << a.teacher if a.teacher.active and not @teachers.include? a.teacher
          end
        end
        @matching = @matching & @teachers unless @teachers.empty?
        @teachers = []
        Teacher.find( :all, :conditions => ["active = ?", true] ).each do |t|
          unless t.subjects.empty?
            t.subjects.each do |s|
              @teachers << t if s.name.downcase.include? word.downcase and not @teachers.include? t
            end
          end
        end
        @matching = @matching & @teachers unless @teachers.empty?
      end
    end
    respond_to do |format|
      format.js { render :action => :matching_teachers }
    end
  end
  #end search method

  def destroy
    @student = Student.find( params[:student_id] )
    if @student.destroy
      render :text => "Student Destroyed"
    else
      render :text => "Student not Destroyed"
    end
  end

  def update
    if current_user.is_a? Student
      @new_address = { :street => params[:student][:street], :number => params[:student][:number], :cap => params[:student][:cap], :country => params[:student][:country], :city => params[:student][:city], :province => params[:student][:province] }
      current_user.address.update_attributes( @new_address )
      sanitize_params :student
      current_user.update_attributes( params[:student] )
    end
      redirect_to :action => :show
  end

end
