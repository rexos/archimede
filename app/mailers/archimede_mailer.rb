# -*- coding: utf-8 -*-
class ArchimedeMailer < ActionMailer::Base
  default :from => "archimede@info.com"

  def confirm_mail( user )
    mail( :to => user.email, :subject => "Benvenuto da Archimede" )
  end

  def restore_password( user, password )
    mail( :to => user.email, :subject => "Password Recovery Archimede", :body => "La Sua nuova Password è : #{password}" )
  end

end
