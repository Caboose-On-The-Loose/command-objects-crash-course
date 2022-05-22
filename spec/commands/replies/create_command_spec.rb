require 'rails_helper'

describe Replies::CreateCommand do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:params) { ActionController::Parameters.new({content: "goodbye", post_id: post.id}) }
  let!(:context) { build(:context, user: user) }

  context '.call' do
    context 'no bad things' do
      subject do
        described_class.call(params, context)
      end

      it 'invokes UserActivityService' do
        expect(Users::ActivityAttemptService).to receive(:call).with(context, Reply)
        subject
      end

      it 'is :ok' do
        expect(subject).to eq(success: Reply.last)
      end
    end

    context 'a spammy user' do
      before do
        stub_wisper_publisher("::Users::RateLimitCommand", :call, :spam)
      end

      subject do
        described_class.call(params, context)
      end

      it 'invokes UserActivityService' do
        expect(Users::ActivityAttemptService).to receive(:call).with(context, Reply)
        subject
      end

      it 'is :redirect' do
        expect(subject).to eq(redirect: "/help/spam")
      end
    end
  end
end
