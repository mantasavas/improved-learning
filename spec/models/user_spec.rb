# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'validating user information' do
    it 'has a valid factory' do
      FactoryGirl.create(:user).should be_valid
    end
    it 'is invalid without a email' do
      FactoryGirl.build(:user, email: nil).should_not be_valid
    end
    it 'is invalid with duplicate emails' do
      FactoryGirl.create(:user, email: 'petras.peraitis@gmail.com', password: 'slaptazodis1', provider: 'facebook', uid: '1254875')
      FactoryGirl.build(:user, email: 'petras.peraitis@gmail.com', password: 'slaptazodis2', provider: 'twitter', uid: '15154757').should_not be_valid
    end
  end

  # TODO: filtering by surname or name, nice to have feature
  describe 'filter email address name by first letter' do
    before :all do
      @tom = FactoryGirl.create(:user, email: 'tom.jacobsdjngflkj@gmail.com', password: 'darvienassadsaf')
      @john = FactoryGirl.create(:user, email: 'johnSmith@gmail.com', password: 'kitasdadsfsdsdfgrv')
      @jack = FactoryGirl.create(:user, email: 'jack.eshot@gmail.com', password: 'idomusisslaptazodis')
    end

    context 'first letter have a match' do
      it 'matched letter array results in ordered order' do
        # puts john.inspect

        # Depricated, needs to be changed!!
        # User.find_mathing_letter("j").each{|user| expect(user.email).to.in? [@jack.email, @john.email]}
        described_class.find_mathing_letter('j').each { |user| user.email.should.in? [@jack.email, @john.email] }
        false
      end
    end

    context 'not a matching first letter' do
      it "does not return users that don't start with the provided letter" do
        described_class.find_mathing_letter('j').should_not include @tom
      end
    end
  end

  describe 'handle callback function return' do
    it 'google returned expected parameters' do
      jsonResponseString = { 'provider' => 'google_oauth2',
                             'uid' => '103648144954862111999',
                             'info' =>
                { 'name' => 'Mantas Savickis',
                  'email' => 'msdntas.ssdfvickis789582@gmail.com',
                  'first_name' => 'Mantas',
                  'last_name' => 'Savickis',
                  'image' => 'https://lh4.googleusercontent.com/-xoTS5TunNgs/AAAAAAAAAAI/AAAAAAAAAAc/i3YMFT0FV9A/photo.jpg' },
                             'credentials' =>
                { 'token' => 'ya29.GlyXBbmAorp48h2TAgAVI0TmFfRcpUep0eUhxReD8ZWOA29OsT0eyBZAQSKDuIyp830hhGuS9BFhn509lcEJFVXu3rJe6ijsws_rJq1hR2auduBJo8Y-nuyzFzB_Nw', 'expires_at' => 1_523_216_443, 'expires' => true },
                             'extra' =>
                { 'id_token' =>
                  'eyJhbGciOiJSUzI1NiIsImtpZCI6IjNiNTQ3ODg2ZmY4NWEzNDI4ZGY0ZjYxZGI3M2MxYzIzOTgyYTkyOGUifQ.eyJhenAiOiIzOTgxMzU1NDk3MjUtcG05c2hqaXU0ZnRhMjQwbmlyZGJiOGJhaWhha2Y0cGguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzOTgxMzU1NDk3MjUtcG05c2hqaXU0ZnRhMjQwbmlyZGJiOGJhaWhha2Y0cGguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDM2NDgxODI5NTE5NjIxMTE5OTkiLCJlbWFpbCI6Im1hbnRhcy5zYXZpY2tpczc4OTJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiI4bzY4cnZoekZGMTlKdzNBWkYzOTFnIiwiZXhwIjoxNTIzMjE2NDQ0LCJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTIzMjEyODQ0fQ.Z9ZZ38Hr9TnsTlQP7fmYy2IcUVtPQO6OgutGAhtKDuhvFMzPNgOg_vBSwbIktESZfTe0_lmMVk_7ZEPSnIOJoeR1bZH6rTX0TrLuTIHcsidahrPuLtTiqGxYfGeO9hKkcotCa7_RwTTHz6ZjwYe_9NRau0lXBvTQ2bZprnk1s0Z7RQfoEISemReswhnwpODUetYKWXrK8Dj3CacwJUTvK9f0OlMEXcoMNg8MwJXaVR0qRxgsxDd8mzw1bi4b3iqRBr-fQYHk72F_3iJRMq4zWWpZOr86xvq04mJPzvNxVom7IQ_Q4HSN0W1snr-1RdQN0eKaUqi7dZZ1AvnshrIr8Q',
                  'id_info' =>
                  { 'azp' => '398135549725-pm9shjiu4fta240nirdbb8baihakf4ph.apps.googleusercontent.com',
                    'aud' => '398135549725-pm9shjiu4fta240nirdbb8baihakf4ph.apps.googleusercontent.com',
                    'sub' => '103648182951962111999',
                    'email' => 'mantas.savickis7892@gmail.com',
                    'email_verified' => true,
                    'at_hash' => '8o68rvhzFF19Jw3AZF391g',
                    'exp' => 1_523_216_444,
                    'iss' => 'accounts.google.com',
                    'iat' => 1_523_212_844 },
                  'raw_info' =>
                  { 'kind' => 'plus#personOpenIdConnect',
                    'sub' => '103648182951962111999',
                    'name' => 'Mantas Savickis',
                    'given_name' => 'Mantas',
                    'family_name' => 'Savickis',
                    'picture' => 'https://lh4.googleusercontent.com/-xoTS5TunNgs/AAAAAAAAAAI/AAAAAAAAAAc/i3YMFT0FV9A/photo.jpg?sz=50',
                    'email' => 'mantas.savickis7892@gmail.com',
                    'email_verified' => 'true',
                    'locale' => 'en' } } }.to_json

      parsedJson = JSON.parse(jsonResponseString, object_class: OpenStruct)
      expect(described_class.from_omniauth(parsedJson)).not_to be_falsey
    end

    it 'google returned wrong email parameter' do
      jsonResponseString = { 'provider' => 'google_oauth2',
                             'uid' => '103648144954862111999',
                             'info' =>
                { 'name' => 'Mantas Savickis',
                  'emails' => 'msdntas.ssdfvickis789582@gmail.com',
                  'first_name' => 'Mantas',
                  'last_name' => 'Savickis',
                  'image' => 'https://lh4.googleusercontent.com/-xoTS5TunNgs/AAAAAAAAAAI/AAAAAAAAAAc/i3YMFT0FV9A/photo.jpg' },
                             'credentials' =>
                { 'token' => 'ya29.GlyXBbmAorp48h2TAgAVI0TmFfRcpUep0eUhxReD8ZWOA29OsT0eyBZAQSKDuIyp830hhGuS9BFhn509lcEJFVXu3rJe6ijsws_rJq1hR2auduBJo8Y-nuyzFzB_Nw', 'expires_at' => 1_523_216_443, 'expires' => true },
                             'extra' =>
                { 'id_token' =>
                  'eyJhbGciOiJSUzI1NiIsImtpZCI6IjNiNTQ3ODg2ZmY4NWEzNDI4ZGY0ZjYxZGI3M2MxYzIzOTgyYTkyOGUifQ.eyJhenAiOiIzOTgxMzU1NDk3MjUtcG05c2hqaXU0ZnRhMjQwbmlyZGJiOGJhaWhha2Y0cGguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzOTgxMzU1NDk3MjUtcG05c2hqaXU0ZnRhMjQwbmlyZGJiOGJhaWhha2Y0cGguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDM2NDgxODI5NTE5NjIxMTE5OTkiLCJlbWFpbCI6Im1hbnRhcy5zYXZpY2tpczc4OTJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiI4bzY4cnZoekZGMTlKdzNBWkYzOTFnIiwiZXhwIjoxNTIzMjE2NDQ0LCJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTIzMjEyODQ0fQ.Z9ZZ38Hr9TnsTlQP7fmYy2IcUVtPQO6OgutGAhtKDuhvFMzPNgOg_vBSwbIktESZfTe0_lmMVk_7ZEPSnIOJoeR1bZH6rTX0TrLuTIHcsidahrPuLtTiqGxYfGeO9hKkcotCa7_RwTTHz6ZjwYe_9NRau0lXBvTQ2bZprnk1s0Z7RQfoEISemReswhnwpODUetYKWXrK8Dj3CacwJUTvK9f0OlMEXcoMNg8MwJXaVR0qRxgsxDd8mzw1bi4b3iqRBr-fQYHk72F_3iJRMq4zWWpZOr86xvq04mJPzvNxVom7IQ_Q4HSN0W1snr-1RdQN0eKaUqi7dZZ1AvnshrIr8Q',
                  'id_info' =>
                  { 'azp' => '398135549725-pm9shjiu4fta240nirdbb8baihakf4ph.apps.googleusercontent.com',
                    'aud' => '398135549725-pm9shjiu4fta240nirdbb8baihakf4ph.apps.googleusercontent.com',
                    'sub' => '103648182951962111999',
                    'email' => 'mantas.savickis7892@gmail.com',
                    'email_verified' => true,
                    'at_hash' => '8o68rvhzFF19Jw3AZF391g',
                    'exp' => 1_523_216_444,
                    'iss' => 'accounts.google.com',
                    'iat' => 1_523_212_844 },
                  'raw_info' =>
                  { 'kind' => 'plus#personOpenIdConnect',
                    'sub' => '103648182951962111999',
                    'name' => 'Mantas Savickis',
                    'given_name' => 'Mantas',
                    'family_name' => 'Savickis',
                    'picture' => 'https://lh4.googleusercontent.com/-xoTS5TunNgs/AAAAAAAAAAI/AAAAAAAAAAc/i3YMFT0FV9A/photo.jpg?sz=50',
                    'email' => 'mantas.savickis7892@gmail.com',
                    'email_verified' => 'true',
                    'locale' => 'en' } } }.to_json
      parsedJson = JSON.parse(jsonResponseString, object_class: OpenStruct)
      expect(described_class.from_omniauth(parsedJson)).to be_falsey
    end
  end
end
