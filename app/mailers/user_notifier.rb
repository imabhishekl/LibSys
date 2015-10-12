class UserNotifier < ApplicationMailer
	default :from => 'no_reply_lib@libsys.edu'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(email_id,subject,book_name)
  	@book_name=book_name
    mail( :to => email_id,
    :subject => subject )
  end
end
