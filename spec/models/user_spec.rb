# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  display_name    :string           not null
#  password_digest :string
#  first_name      :string
#  last_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_display_name  (display_name) UNIQUE
#  index_users_on_email         (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without an email' do
    subject.email = nil
    should be_invalid
  end

  it 'is invalid without a display name' do
    subject.display_name = nil
    should be_invalid
  end

  it 'is invalid when the email has already been taken' do
    create :user, email: subject.email
    should be_invalid
  end

  it 'is invalid when the display name has already been taken' do
    create :user, display_name: subject.display_name
    should be_invalid
  end
end
