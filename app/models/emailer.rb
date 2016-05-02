class Emailer < ActionMailer::Base
  def send_email(recipient,subject,message,send_at = Time.now)
    @subject = subject
    @recipients = recipient
    @from = "Argamente@outlook.com"
    @send_on = send_at
        @body["title"] = "This is title"
        @body["email"] = "Argamente@outlook.com"
        @body["message"] = message
    @headers = {}
  end
end