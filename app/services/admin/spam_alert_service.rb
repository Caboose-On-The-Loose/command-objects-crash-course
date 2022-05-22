module Admin
  class SpamAlertService
    def self.call(context)
      ::Admin::NotificationMailer.notify("Potentially spam user##{context.user.id}",
                                         "Potential spam from #{context.ip_address} / #{context.user_agent}").deliver!
    end
  end
end
