module Moderation
  module WithActivity
    def with_activity(klass)
      Users::ActivityAttemptService.call(@context, klass)
      yield Users::RateLimitCommand.new(@context, klass)
    end
  end
end

