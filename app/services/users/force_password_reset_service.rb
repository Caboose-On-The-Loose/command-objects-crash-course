module Users
  class ForcePasswordResetService
    def self.call(user, password = SecureRandom.hex)
      user.update!(password: password)
      Users::PasswordMailer.reset(user).deliver!
    end
  end
end
