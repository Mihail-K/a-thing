# frozen_string_literal: true
# == Schema Information
#
# Table name: password_resets
#
#  id         :uuid             not null, primary key
#  user_id    :integer
#  status     :string           default("pending"), not null
#  email      :string           not null
#  ip         :inet
#  remote_ip  :inet
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_password_resets_on_id                  (id) UNIQUE
#  index_password_resets_on_status              (status)
#  index_password_resets_on_user_id             (user_id)
#  index_password_resets_on_user_id_and_status  (user_id,status) UNIQUE
#

require 'rails_helper'

RSpec.describe PasswordReset, type: :model do
  subject { build(:password_reset) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without an email' do
    subject.email = nil
    should be_invalid
  end

  it 'is invalid without a status' do
    subject.status = nil
    should be_invalid
  end

  it 'sets a user from an email address' do
    subject.user = nil
    subject.email = create(:user).email
    expect { subject.save }.to change { subject.user }
  end

  it 'marks other password resets expired when created' do
    other = create(:password_reset, user: subject.user)
    expect { subject.save }.to change { other.reload.status }.from('pending').to('expired')
  end

  context 'when completed' do
    subject { build(:password_reset, :completed) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without a user' do
      subject.user = nil
      should be_invalid
    end

    it 'is invalid without a password' do
      subject.password = nil
      should be_invalid
    end

    it "is invalid if the password doesn't match the confirmation" do
      subject.password_confirmation = Faker::Internet.password
      should be_invalid
    end

    it "changes the user's password" do
      expect { subject.save }.to change { subject.user.password_digest }
    end
  end
end
