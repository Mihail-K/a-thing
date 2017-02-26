# frozen_string_literal: true
Rails.application.routes.draw do
  resources :password_resets, only: %i(show create update)
  resources :sessions, only: %i(show create destroy)
  resources :users
end
