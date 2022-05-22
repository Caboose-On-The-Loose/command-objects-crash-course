FactoryBot.define do
  factory :context, class: 'User::Context' do
    user
    initialize_with { new(user).for(OpenStruct.new(remote_ip: "127.0.0.1", user_agent: "Fake")) }
  end
end
