# frozen_string_literal: true

# Handling main subject funcionality: basic CRUD (create, delete, update subject and it's description)
class SubjectController < ApplicationController
  before_action :check_access, only: :index
  def index
  end

  private
  
  def check_access
    redirect_to(unauthenticated_root_url) unless user_signed_in?
  end
end
