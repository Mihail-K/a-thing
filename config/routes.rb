# frozen_string_literal: true
Rails.application.routes.draw do
  resources :sessions, only: %i(show create destroy)
  resources :users
end
