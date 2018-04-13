# frozen_string_literal: true

FactoryBot.define do
  factory :user do |f|
    f.email 'matas@gmail.com'
    f.password 'kalfijroas'
    f.uid '12548793'
    f.provider 'google_oauth2'
  end
end
