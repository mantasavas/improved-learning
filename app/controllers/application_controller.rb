# frozen_string_literal: true

# Main controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # After user successfuly logged in, redirect to Main page, accessible only for logged in users
  def after_sign_in_path_for(user)
    # binding.pry
    subjects_url(user)
  end
end
