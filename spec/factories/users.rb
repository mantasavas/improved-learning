# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'matas@gmail.com'
    password 'kalfijroas'
    uid '12548793'
    provider 'google_oauth2'

    factory :user_with_subject do
      after(:create) do |user|
        create(:subject, user: user)
      end
    end
  end

  factory :subject do
    title 'This is long title'
    body 'Inside body. This must be at least 30 symbols long'
  end
end
