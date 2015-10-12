class NotificationMail < ApplicationMailer
  default from: "libsys.rails@gmail.com"
  layout 'mailer'

  def self.send_notification email_id
    mail(to: email_id, subject: 'LibSys')
  end

  def registration_confirmation()
  recipients  "aslingwa@ncsu.edu"
  from        "libsys.rails@gmail.com"
  subject     "Thank you for Registering"
  body        :user => "sdas"
end
end
