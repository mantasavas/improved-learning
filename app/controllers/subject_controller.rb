# frozen_string_literal: true

# Handling main subject funcionality: basic CRUD (create, delete, update subject and it's description)
class SubjectController < ApplicationController
  before_action :check_access, only: :index
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @subject = Subject.all.order('created_at DESC')
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    puts "This is a test!!!!!!!!!!!!"
    @subject = Subject.new
    puts "This is a test!!!!!!!!!!!!"
  end

  def create

  	@subject = Subject.new(subject_params)

  	if @subject.save
      redirect_to @subject
    else
      # Rencer because it doesn't do another http refresh, and user won't lose all his data in a form he typed in
      render 'new'
    end
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      redirect_to @subject
    else
      render 'edit'
    end
  end

  def destroy
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
