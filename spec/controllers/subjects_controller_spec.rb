# frozen_string_literal: true

require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe SubjectsController, type: :controller do
  render_views

  let(:user) { create(:user_with_subject) }

  before do
    allow(controller).to receive(:user_signed_in?).and_return(false)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    context 'when user is unauthenticated' do
      it 'redirects to login' do
        get :new
        expect(response).to redirect_to unauthenticated_root_url
      end
    end

    context 'when user is authenticated' do
      it 'assigns @subject to new' do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        get :new
        expect(assigns(:subject)).to be_a_new(Subject)
      end

      it 'renders the subject template' do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        get :new
        expect(response).to render_template('subjects/new')
      end
    end

    before { login_as(user, scope: :user) }

    before do
      visit 'subjects/new'
      fill_in 'subject[title]', with: 'Subject Title'
      fill_in 'subject[body]', with: 'In subject body. This must be longer then 20 symbols minimum'
    end

    context 'when user saves subject' do
      it 'creates the subject and redirect to subject view' do
        find('[name=commit]').click
        current_path.should eq '/subjects/2'
      end

      it 'adds subject in subjects table' do
        expect { find('[name=commit]').click }.to change(Subject, :count).by(1)
      end
    end

    context 'when user fails to save subject' do
      it 'title is too short' do
        fill_in 'subject[title]', with: 'ss'
        find('[name=commit]').click
        current_path.should eq '/subjects'
      end

      it 'body is too short' do
        fill_in 'subject[body]', with: 'ss'
        find('[name=commit]').click
        current_path.should eq '/subjects'
      end

      it 'subject is not saved in subjects table' do
        fill_in 'subject[title]', with: 'ss'
        expect { find('[name=commit]').click }.to change(Subject, :count).by(0)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is not logged in' do
      it 'cannot see subject index page' do
        get :index
        expect(response).to redirect_to unauthenticated_root_url
      end
    end

    context 'when user logged in' do
      it 'can see subject index page' do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        get :index
        expect(response).to render_template('subjects/index')
      end
    end
  end
end
