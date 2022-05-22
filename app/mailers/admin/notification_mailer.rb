module Admin
  class NotificationMailer < ApplicationMailer
    layout false

    def notify(subject, content)
      mail(to: "admin@example.com", subject: subject, html_body: content) do |format|
        format.text { render plain: content }
      end
    end
  end
end
