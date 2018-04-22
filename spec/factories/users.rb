# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'matas.savickis@gmail.com'
    password 'slaptasraktas'
    uid '12548793'
    provider 'google_oauth2'

    factory :user_with_subject do
      after(:create) do |user|
        create(:subject, user: user)
      end
    end
  end
end
