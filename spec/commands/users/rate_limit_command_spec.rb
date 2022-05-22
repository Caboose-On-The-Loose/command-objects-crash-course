require 'rails_helper'

describe Users::RateLimitCommand do
  let!(:user) { create(:user) }
  let(:context) { build(:context, user: user) }

  subject do
    described_class.call(context, Post)
  end

  context 'limit exceeded' do
    before do
      allow_any_instance_of(described_class).to receive(:limit_exceeded?).and_return(true)
    end

    context 'spam' do
      before do
        allow_any_instance_of(described_class).to receive(:potentially_spam?).and_return(true)
      end

      it 'returns :spam' do
        expect(subject).to eq(spam: [])
      end

      it 'invokes ::Admin::SpamAlertService' do
        expect(::Admin::SpamAlertService).to receive(:call).with(context)
        subject
      end

      it 'invokes ::Users::ForcePasswordResetService' do
        expect(::Users::ForcePasswordResetService).to receive(:call).with(context.user)
        subject
      end
    end

    subject do
      described_class.call(context, Post)
    end

    it 'returns :spam' do
      expect(subject).to eq(rate_limited: [])
    end
  end

  context 'everything ok' do
    it 'returns ok' do
      events = subject

      expect(events).to eq(ok: [])
    end
  end
end
