require 'rails_helper'

describe Users::ForcePasswordResetService do
  let!(:user) { create(:user) }
  context '.call' do
    it 'changes the password' do
      expect { described_class.call(user) }.to change(user, :encrypted_password)
    end

    it 'delivers an email' do
      expect { described_class.call(user) }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'delivers Users::PasswordMailer#reset' do
      expect(Users::PasswordMailer).to receive(:reset).with(user).and_return(Users::PasswordMailer.reset(user))
      described_class.call(user)
    end
  end
end
