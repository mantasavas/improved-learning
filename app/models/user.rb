# frozen_string_literal: true

# Storing to user related data
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :subjects

  META = %i[id created_at updated_at].freeze

  # Function handling callback from google
  def self.from_omniauth(auth)
    # binding.pry
    if !auth.provider.nil? && !auth.uid.nil? && !auth.info.email.nil?
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    else
      false
    end
  end

  # Returns all users, there emails have a match
  def self.find_mathing_letter(letter)
    where('email LIKE ?', "#{letter}%").order(:email)
  end

  #   # From stackoverflow: https://stackoverflow.com/questions/4738439/how-to-test-for-activerecord-object-equality
  #   # Can't compare active record objects using matchers in rspec so need some kind of functions into rescue
  #   def self.eql_attributes?(original,new)
  #      original = original.reject {|column| column.name == META}
  #      new = new.attributes.symbolize_keys.with_indifferent_access.except(*META)
  #      original == new
  #   end
end
