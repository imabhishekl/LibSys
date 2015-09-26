class NotificationMail < ApplicationMailer
  default from: "libsys.rails@gmail.com"
  layout 'mailer'

  def self.send_notification email_id
    mail(to: email_id, subject: 'LibSys')
  end
end
