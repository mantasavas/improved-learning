# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:jonas) { build(:user) }

  it 'has a valid factory' do
    expect(build(:subject, user: jonas)).to be_valid
  end

  context 'when subject attributes have valid length' do
    it { is_expected.to validate_length_of(:title).is_at_least(5).on(:create) }
    it { is_expected.to validate_length_of(:body).is_at_least(20).on(:create) }
  end
end
