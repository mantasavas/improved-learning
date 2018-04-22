# frozen_string_literal: true

class Subject < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 20 }

  belongs_to :user
end
