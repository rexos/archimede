class ArchimedeMailer < ActionMailer::Base
  default :from => "archimede@info.com"

  def confirm_mail( user )
    mail( :to => user.email, :subject => "Welcome mail from Archimede" )
  end

end
