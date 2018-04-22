# frozen_string_literal: true

FactoryBot.define do
  factory :subject do
    title 'This is long title'
    body 'Inside body. This must be at least 30 symbols long'
  end
end
