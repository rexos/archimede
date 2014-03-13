class StudentsController < ApplicationController
  before_filter :logged_in?, :except => [:create, :search_teacher]
  before_filter :is_student?, :except => [:create, :search_teacher]
  
  def create
    @address = Address.new( :street => params[:student][:street], :cap => params[:student][:cap], :country => params[:student][:country], :number => params[:student][:number] )
    @address.city = params[:student][:city]
    @address.province = params[:student][:province]
    sanitize_params :student
    @student = Student.new( params[:student] )

    if @student.save
      @student = Student.find_by_email( @student.email )
      @student.address = @address
      #render :text => "Ok Student correctly saved"
      session[:user_id] = @student.id
      redirect_to :action => :show
    else
      #render :text => "Student not created"
      #respond_to do |format|
      #  format.js { render :action => 'error_registered.js.erb' }
      #end

      err = "Errori: "
      @student.errors.full_messages.each do |msg|
        err.concat(msg + ", ")
      end
      flash[:signup_error] = err

      redirect_to :controller => :teachers, :action => :signup
    end

  end

  def show
  end

  def change_password
    change_psw
  end


  def rate_teacher
    @teacher = Teacher.find( session[:visited] )
    if @teacher and @teacher.rating_bool
      @teacher.ratings << current_user.ratings.create( :value => params[:rating_value] )
      respond_to do |format|
        format.js { render :success => true, :nothing => true }
      end
    else
      respond_to do |format|
        format.js { render :success => false, :nothing => true }
      end
    end
  end

  #search teacher method
  def search_teacher
    if current_user and current_user.is_a? Teacher
      redirect_to :controller => :teachers, :action => :show
    end
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
