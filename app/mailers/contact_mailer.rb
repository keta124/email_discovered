class ContactMailer < ApplicationMailer

  def send_to_admin email, subject, message
    @email = email
    @message = message
    mail to: 'jwpolo@berkeley.edu',
      reply_to: email,
      subject: subject
  end

end
