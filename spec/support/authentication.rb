# frozen_string_literal: true
require 'rails_helper'

RSpec.shared_context 'authentication' do
  let(:current_user) { create(:user) }
  let(:current_session) { create(:session, user: current_user) }
  let(:session_token) { current_session.id }
end
