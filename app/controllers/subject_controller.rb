# frozen_string_literal: true

# Handling main subject funcionality: basic CRUD (create, delete, update subject and it's description)
class SubjectController < ApplicationController
  before_action :check_access, only: %i[index show edit update destroy display_all create new]
  before_action :find_user, only: %i[show edit update destroy]

  # Displays all users subjects
  def index
    # Gets current logged in user subjects
    @subject = current_user.subjects
  end

  # Displays all subjects
  def display_all
    @subject = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
    @belongs = current_user == @subject.user
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.user = current_user

    if @subject.save
      redirect_to @subject
    else
      # Render because it doesn't do another http refresh, and user won't lose all his data in a form he typed in
      render 'new'
    end
  end

  def edit; end

  def update
    if @subject.update(subject_params)
      redirect_to @subject
    else
      render 'edit'
    end
  end

  def destroy
    @subject.destroy

    redirect_to subjects_path
  end

  private

  def check_access
    redirect_to(unauthenticated_root_url) unless user_signed_in?
  end

  def subject_params
    params.require(:subject).permit(:title, :body)
  end

  def find_user
    @subject = Subject.find(params[:id])
  end
end
