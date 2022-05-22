require 'rails_helper'

describe Users::ActivityAttemptService do
  let!(:user) { create(:user) }
  let!(:context) { User::Context.new(user).for(OpenStruct.new(remote_ip: '127.0.0.1', user_agent: "Fake")) }

  context 'all things good' do
    it 'succeeds' do
      expect(::Moderation::CreateActivityService).to receive(:call).with(context, Moderation::Attempt, kind: Post)
      described_class.call(context, Post)
    end
  end
end
