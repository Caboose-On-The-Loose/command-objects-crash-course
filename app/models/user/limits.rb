class User::Limits
  def initialize(user)
    @user = user
  end

  def max(what)
    return max_posts_per_day if what == Post
    return max_replies_per_day if what == Reply

    raise ArgumentError, "unknown #{what}"
  end

  def max_posts_per_day
    if trusted?
      return 25 if older_than_seven_days?
      return 5
    end

    return 5 if older_than_seven_days?
    1
  end

  def max_replies_per_day
    if trusted?
      return 100 if older_than_seven_days?
      return 10
    end

    return 10 if older_than_seven_days?
    5
  end

  private

  def older_than_seven_days?
    @user.created_at < 7.days.ago
  end

  def trusted?
    @user.status == 'trusted'
  end
end
