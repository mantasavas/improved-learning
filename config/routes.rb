# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  devise_scope :user do
    authenticated :user do
      root 'welcome#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :subjects
  get '/display_all', to: 'subjects#display_all'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
