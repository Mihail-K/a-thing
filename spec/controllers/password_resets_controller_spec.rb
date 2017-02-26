# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe '#GET show' do
    let(:password_reset) { create(:password_reset) }

    it 'returns the requested password reset' do
      get :show, params: { id: password_reset.id }

      expect(response).to have_http_status :ok
    end
  end

  describe '#POST create' do
    let(:user) { create(:user) }

    it 'creates a new password reset for a user' do
      expect do
        post :create, params: { password_reset: { email: user.email } }

        expect(response).to have_http_status :created
        expect(response.body).to be_empty
      end.to change { PasswordReset.count }.by(1)

      expect(PasswordReset.last.user).to eq(user)
    end

    it 'creates a new password reset with no attached user' do
      expect do
        post :create, params: { password_reset: { email: Faker::Internet.email } }

        expect(response).to have_http_status :created
        expect(response.body).to be_empty
      end.to change { PasswordReset.count }.by(1)

      expect(PasswordReset.last.user).to be_nil
    end

    it 'returns errors when the password reset is invalid' do
      expect do
        post :create, params: { password_reset: { email: '' } }

        expect(response).to have_http_status :unprocessable_entity
      end.not_to change { PasswordReset.count }
    end
  end

  describe '#PATCH update' do
    let(:password_reset) { create(:password_reset) }

    it 'completes the password reset process' do
      expect do
        patch :update, params: { id: password_reset.id,
                                 password_reset: attributes_for(:password_reset, :completed) }

        expect(response).to have_http_status :ok
      end.to change { password_reset.reload.status }.from('pending').to('completed')
    end

    it 'returns errors when the password reset is invalid' do
      expect do
        patch :update, params: { id: password_reset.id,
                                 password_reset: attributes_for(:password_reset, :completed, password: '') }

        expect(response).to have_http_status :unprocessable_entity
      end.not_to change { password_reset.reload.status }
    end
  end
end
