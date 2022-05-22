class User::Context
  InternalContext = Struct.new(:user_agent, :ip_address, :user, keyword_init: true)

  def initialize(user)
    @user = user
  end

  def for(request)
    InternalContext.new(
      user_agent: request.user_agent,
      ip_address: request.remote_ip,
      user: @user
    )
  end
end
