module Users
  class ActivityCreateService
    def self.call(context, thing)
      ::Moderation::CreateActivityService.call(context, ::Moderation::Creation, thing: thing)
    end
  end
end
