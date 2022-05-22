module Users
  class ActivityAttemptService
    def self.call(context, klass)
      ::Moderation::CreateActivityService.call(context, ::Moderation::Attempt, kind: klass)
    end
  end
end
