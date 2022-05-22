module Users
  class RateLimitCommand < ApplicationCommand
    SPAM_WINDOW = 3.days.ago
    SPAM_THRESHOLD = 0.2

    def initialize(context, klass)
      @context = context
      @klass = klass
      @user_limits = User::Limits.new(@context.user)
    end

    def call
      @limit = @user_limits.max(@klass)
      if limit_exceeded?(@klass)
        if potentially_spam?
          ::Admin::SpamAlertService.call(@context)
          ::Users::ForcePasswordResetService.call(@context.user)
          return broadcast(:spam)
        end

        return broadcast(:rate_limited)
      end

      broadcast(:ok)
    end

    private

    def limit_exceeded?(klass)
      (klass.where(user: @context.user).count + 1) > @limit
    end

    def potentially_spam?
      activity_log_count > spam_threshold
    end

    def activity_log_count
      ::Moderation::Attempt
        .where(user: @context.user)
        .where('created_at > ?', SPAM_WINDOW).count
    end

    def spam_threshold
      @limit + (@limit * SPAM_THRESHOLD).round
    end
  end
end
