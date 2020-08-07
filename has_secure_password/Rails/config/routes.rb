# frozen_string_literal: true

Rails.application.routes.draw do
  get 'user_login/login'
  post 'user_login/auth'
  get 'user_login/logout'
  root 'top#index'
  resources :users, only: %i[new create edit update] do
    collection do
      get 'complete'
      get 'quit'
      get 'quit_complete'
    end
  end
end
