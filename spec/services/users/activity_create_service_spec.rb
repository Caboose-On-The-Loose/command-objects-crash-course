require 'rails_helper'

describe Users::ActivityCreateService do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:context) { User::Context.new(user).for(OpenStruct.new(remote_ip: '127.0.0.1', user_agent: "Fake")) }

  context 'all things good' do
    it 'succeeds' do
      expect(::Moderation::CreateActivityService).to receive(:call).with(context, Moderation::Creation, thing: post)
      described_class.call(context, post)
    end
  end
end

