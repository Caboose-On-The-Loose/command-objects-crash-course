require 'rails_helper'

describe Posts::CreateCommand do
  let!(:user) { create(:user) }
  let!(:params) { ActionController::Parameters.new({subject: "hello", content: "goodbye"}) }
  let!(:context) { build(:context, user: user) }

  context '.call' do
    context 'no bad things' do
      subject do
        described_class.call(params, context)
      end

      it 'invokes UserActivityService' do
        expect(Users::ActivityAttemptService).to receive(:call).with(context, Post)
        subject
      end

      it 'is :ok' do
        expect(subject).to eq(success: Post.last)
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
        expect(Users::ActivityAttemptService).to receive(:call).with(context, Post)
        subject
      end

      it 'is :redirect' do
        expect(subject).to eq(redirect: "/help/spam")
      end
    end
  end
end
