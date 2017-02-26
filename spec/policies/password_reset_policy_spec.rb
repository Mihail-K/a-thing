# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PasswordResetPolicy do
  let(:user) { User.new }

  subject { described_class }

  permissions :create? do
    it 'allows guests to reset their passwords' do
      should permit(nil, PasswordReset.new)
    end

    it "doesn't allow users to reset their passwords" do
      should_not permit(user, PasswordReset.new)
    end
  end
end
