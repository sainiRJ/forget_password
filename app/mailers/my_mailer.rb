class MyMailer < ApplicationMailer
    def send_email(to_email, subject, content)
      from_email = 'rajeshpushpakar01@gmail.com'
      mail(to: to_email, subject: subject) do |format|
        format.text { render plain: content }
        format.html { render html: content }
      end
    end
  end