# frozen_string_literal: true

# Storing to user related data
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, uniqueness: true
  has_many :subjects, dependent: :destroy

  def self.from_omniauth(auth)
    # binding.pry
    if !auth.provider.nil? && !auth.uid.nil? && !auth.info.email.nil?
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        return true
      end
    else
      false
    end
  end

  def self.find_matching_letter(letter)
    where('email LIKE ?', "#{letter}%").order(:email)
  end
end
