# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#GET show' do
    let(:session) { create(:session) }

    it 'returns the requested session' do
      get :show, params: { id: session.id, session_token: session.id }

      expect(response).to have_http_status :ok
    end
  end

  describe '#POST create' do
    let(:user) { create(:user) }

    it 'creates a new session' do
      expect do
        post :create, params: { session: { email: user.email, password: user.password } }

        expect(response).to have_http_status :created
      end.to change { Session.count }.by(1)
    end

    it 'returns errors when the session is invalid' do
      expect do
        post :create, params: { session: { email: user.email, password: Faker::Internet.password } }

        expect(response).to have_http_status :unprocessable_entity
      end.not_to change { Session.count }
    end
  end

  describe '#DELETE destroy' do
    let(:session) { create(:session) }

    it 'requires authentication' do
      expect do
        delete :destroy, params: { id: session.id }

        expect(response).to have_http_status :unauthorized
      end.not_to change { session.reload.active? }
    end

    it 'closed the session' do
      expect do
        delete :destroy, params: { id: session.id, session_token: session.id }

        expect(response).to have_http_status :no_content
      end.to change { session.reload.active? }.from(true).to(false)
    end
  end
end
