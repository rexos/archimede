class StudentsController < ApplicationController
  before_filter :logged_in?, :except => :create
  before_filter :is_student?, :except => :create
  before_filter :set_http_return, :except => [ :search_teacher ]

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

  #search teacher method
  def search_teacher
    words = sanitize_search_text( params[:search][:text] )
    @matching = @teachers = []
    if words.size > 0
      @teachers = Teacher.find( :all, :conditions => ["( name LIKE ? OR last_name LIKE ? ) AND active = ?", "%#{words[0]}%", "%#{words[0]}%", true] )
      Address.find( :all, :conditions => ["city LIKE ?", "%#{words[0]}%"] ).each do |a|
        @teachers << a.teacher unless @teachers.include? a.teacher and not a.teacher.active
      end
      @by_subject = Teacher.find( :all, :conditions => ["active = ?", true] )
      @by_subject.each do |t|
        unless t.subjects.empty?
          t.subjects.each do |s|
            if s.name.include? words[0]
              @teachers << t unless @teachers.include? t
            end
          end
        end
      end
      @matching = @teachers
      i = 1
      while i < words.size
        @teachers = Teacher.find( :all, :conditions => ["( name LIKE ? OR last_name LIKE ? ) AND active = ?", "%#{words[i]}%", "%#{words[i]}%", true] )
        Address.find( :all, :conditions => ["city LIKE ?", "%#{words[i]}%"] ).each do |a|
          @teachers << a.teacher if a.teacher and !@teachers.include? a.teacher and a.teacher.active
        end
        @by_subject= Teacher.find( :all, :conditions => ["active = ?", true] )
        @by_subject.each do|t|
          if t.subjects
            t.subjects.each do |s|
              if s.name.include? words[i]
                @teachers << t unless @teachers.include? t
              end
            end
          end
        end
        @matching = @matching & @teachers
      end
    end


    #for w in words
    #  @teachers = Teacher.find( :all, :conditions => ["name LIKE ? AND active = ?", "%#{w}%", true] ) # find by name
    #  Teacher.find( :all, :conditions => ["last_name LIKE ? AND active = ?", "%#{w}%", true] ).each do |t| #find by last name
    #    @teachers << t unless @teachers.include? t
    #  end
    #  Address.find( :all, :conditions => ["city LIKE ?", "%#{w}%"] ).each do |a| #find by address
    #    @teachers << a.teacher unless @teachers.include? a.teacher and not a.teacher.active
    #  end
    #  @by_subjects = Teacher.find( :all, :conditions => ["active = ?", true] )
    #  @by_subjects.each do |t|  #find by subjects
    #    if t.subjects
    #      t.subjects.each do |s|
    #        if s.name.include? w
    #        @teachers << t unless @teachers.include? t
    #        end
    #      end
    #    end
    #  end
    #  if @teachers
    #    @teachers.each do |t|
    #      @matching << t unless @matching.include? t
    #    end
    #  end
    #end
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
    current_user.update_attributes( params[:student] )
    redirect_to :action => :show
  end

end
