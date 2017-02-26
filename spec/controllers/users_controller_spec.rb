# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include_context 'authentication'

  describe '#GET index' do
    let!(:users) { create_list(:user, 3) }

    it 'returns a list of users' do
      get :index

      expect(response).to have_http_status :ok
    end
  end

  describe '#GET show' do
    let(:user) { create(:user) }

    it 'returns the requested user' do
      get :show, params: { id: user.id }

      expect(response).to have_http_status :ok
    end
  end

  describe '#POST create' do
    it 'creates a new user' do
      expect do
        post :create, params: { user: attributes_for(:user) }

        expect(response).to have_http_status :created
      end.to change { User.count }.by(1)
    end

    it 'returns errors if the user is invalid' do
      expect do
        post :create, params: { user: attributes_for(:user, email: '') }

        expect(response).to have_http_status :unprocessable_entity
      end.not_to change { User.count }
    end
  end

  describe '#PATCH update' do
    it 'requires authentication' do
      expect do
        patch :update, params: { id: current_user.id,
                                 user: { email: Faker::Internet.email } }

        expect(response).to have_http_status :unauthorized
      end.not_to change { current_user.reload.email }
    end

    it 'updates attributes on the user' do
      expect do
        patch :update, params: { id: current_user.id,
                                 user: { email: Faker::Internet.email },
                                 session_token: session_token }

        expect(response).to have_http_status :ok
      end.to change { current_user.reload.email }
    end

    it 'returns errors if the user is invalid' do
      expect do
        patch :update, params: { id: current_user.id,
                                 user: { email: '' },
                                 session_token: session_token }

        expect(response).to have_http_status :unprocessable_entity
      end.not_to change { current_user.reload.email }
    end
  end

  describe '#DELETE destroy' do
    before(:each) { current_user }

    it 'requires authentication' do
      expect do
        delete :destroy, params: { id: current_user.id }

        expect(response).to have_http_status :unauthorized
      end.not_to change { User.count }
    end

    it 'deletes the current user' do
      expect do
        delete :destroy, params: { id: current_user.id, session_token: session_token }

        expect(response).to have_http_status :no_content
      end.to change { User.count }.by(-1)
    end
  end
end
