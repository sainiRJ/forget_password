class UserMailer < ApplicationMailer
    def send_plain_text_email(email, subject, message)
      mail(to: email, subject: subject, body: message)
    end
  end
  