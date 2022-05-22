require 'rails_helper'

describe Moderation::CreateActivityService do
  let!(:user) { create(:user) }
  let(:context) { build(:context, user: user) }

  context 'when creation' do
    let!(:post) { create(:post) }

    subject do
      described_class.call(context, Moderation::Creation, thing: post)
    end

    it 'creates a record ' do
      expect {
        subject
      }.to change(Moderation::Creation, :count).by(1)
    end

    it 'creates with a thing' do
      expect(subject.thing).to eq(post)
    end
  end

  context 'when attempt' do
    subject do
      described_class.call(context, Moderation::Attempt, kind: 'Post')
    end

    it 'creates a record ' do
      expect {
        subject
      }.to change(Moderation::Attempt, :count).by(1)
    end

    it 'creates with a thing' do
      expect(subject.kind).to eq('Post')
    end
  end
end
