require 'rails_helper'

describe Admin::SpamAlertService do
  let(:context) { build(:context) }
  it 'should deliver mail' do
    expect { described_class.call(context) }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end

  it 'should send the right mailer' do
    expect(Admin::NotificationMailer).to receive(:notify)
                                           .with("Potentially spam user##{context.user.id}",
                                                               "Potential spam from #{context.ip_address} / #{context.user_agent}")
                                           .and_return(OpenStruct.new)
    described_class.call(context)
  end
end
