module Users
  class PasswordMailer < ApplicationMailer
    def reset(user)
      mail(to: user.email, subject: "Please reset your password") do |format|
        format.html { render plain: "Your password was automatically reset."}
      end
    end
  end
end
