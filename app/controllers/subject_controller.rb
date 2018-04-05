# frozen_string_literal: true

# Handling main subject funcionality: basic CRUD (create, delete, update subject and it's description)
class SubjectController < ApplicationController
  before_action :check_access, only: :index
  def index
  end

  def new
  	@subject = Subject.new
  end

  def create
  	@subject = Subject.new(subject_params)
  	@subject.save

  	redirect_to @subject
  end

  def show
    @subject = Subject.find(params[:id])
  end

  private
  
  def check_access
    redirect_to(unauthenticated_root_url) unless user_signed_in?
  end

  def subject_params
  	params.require(:subject).permit(:title, :body)
  end
end
