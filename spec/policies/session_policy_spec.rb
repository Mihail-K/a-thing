# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SessionPolicy do
  let(:user) { User.new }

  subject { described_class }

  permissions :create? do
    it 'allows guests to create new sessions' do
      should permit(nil, Session.new)
    end

    it "doesn't allow users to create new sessions" do
      should_not permit(user, Session.new)
    end
  end

  permissions :destroy? do
    it "doesn't allow guests to close sessions" do
      should_not permit(nil, Session.new(user: user))
    end

    it 'allows users to close sessions they own' do
      should permit(user, Session.new(user: user))
    end

    it "doesn't allow users to close sessions they don't own" do
      should_not permit(user, Session.new(user: build(:user)))
    end
  end
end
