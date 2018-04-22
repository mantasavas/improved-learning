# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe '.from_omniauth?' do
    let(:auth_object) do
      double(
        provider: 'google_oauth2',
        uid: '103648144954862111999',
        info: double(
          email: 'mantas.savickis7892@gmail.com',
          first_name: 'Mantas',
          last_name: 'Savickis'
        )
      )
    end

    context 'when authentication object is valid' do
      it { expect(described_class.from_omniauth(auth_object)).not_to be_falsey }
    end

    context 'when authentication object is not valid' do
      it 'missing email' do
        allow(auth_object).to receive_message_chain('info.email') { nil }
        expect(described_class.from_omniauth(auth_object)).to be_falsey
      end
      it 'missing provider' do
        allow(auth_object).to receive('uid').and_return(nil)
        expect(described_class.from_omniauth(auth_object)).to be_falsey
      end
      it 'missing uid' do
        allow(auth_object).to receive('provider').and_return(nil)
        expect(described_class.from_omniauth(auth_object)).to be_falsey
      end
    end
  end

  describe '.find_matching_letter' do
    let!(:tomas) { create(:user, email: 'tomas.steponavicius@gmail.com') }
    let!(:petras) { create(:user, email: 'petras.kirtis@gmail.com') }
    let!(:povilas) { create(:user, email: 'povilas.remiga25@gmail.com') }

    context 'when found matching letter' do
      it 'return p letter matches' do
        described_class.find_matching_letter('p').each { |user| user.email.should.in? [petras.email, povilas.email] }
      end

      it 'return t letter matches' do
        described_class.find_matching_letter('t').each { |user| user.email.should.in? [tomas.email] }
      end
    end

    context 'when did not found any email matches' do
      it 'return r letter empty match' do
        expect(described_class.find_matching_letter('r')).to be_empty
      end
    end

    context 'when did not found unmatching latter emails' do
      it 'return only t matches' do
        described_class.find_matching_letter('t').each { |user| expect(user.email).not_to include(petras.email, povilas.email) }
      end
    end
  end

  context 'when user has many subjects' do
    it { is_expected.to have_many(:subjects) }
  end

  context 'when duplicate emails' do
    it 'is not valid' do
      create(:user, email: 'petras.peraitis@gmail.com')
      expect(build(:user, email: 'petras.peraitis@gmail.com')).not_to be_valid
    end
  end
end
