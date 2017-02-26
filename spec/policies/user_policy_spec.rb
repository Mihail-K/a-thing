# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserPolicy do
  let(:user) { User.new }

  subject { described_class }

  permissions :create? do
    it 'allows guests to create new accounts' do
      should permit(nil, User.new)
    end

    it "doesn't allow existing user to create new accounts" do
      should_not permit(user, User.new)
    end
  end

  permissions :update? do
    it "doesn't allow guests to edit user accounts" do
      should_not permit(nil, user)
    end

    it 'allows users to edit their own accounts' do
      should permit(user, user)
    end

    it "doesn't allow users to edit the accounts of other users" do
      should_not permit(user, User.new)
    end
  end

  permissions :destroy? do
    it "doesn't allow guests to delete user accounts" do
      should_not permit(nil, user)
    end

    it 'allows users to delete their own accounts' do
      should permit(user, user)
    end

    it "doesn't allow users to delete the accounts of other users" do
      should_not permit(user, User.new)
    end
  end
end
