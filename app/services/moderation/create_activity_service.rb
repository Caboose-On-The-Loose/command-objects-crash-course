module Moderation
  class CreateActivityService
    def self.call(context, type, thing: nil, kind: nil)
      type.create!(
        user: context.user,
        ip_address: IpAddress.find_or_create_by!(ip: context.ip_address),
        user_agent: UserAgent.find_or_create_by!(name: context.user_agent),
        kind: kind,
        thing: thing
      )
    end
  end
end
