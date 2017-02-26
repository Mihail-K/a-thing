# frozen_string_literal: true
# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  user_id    :integer          not null
#  ip         :inet
#  remote_ip  :inet
#  active     :boolean          default("true"), not null
#  expires_at :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sessions_on_active   (active)
#  index_sessions_on_id       (id) UNIQUE
#  index_sessions_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { build(:session) }

  it 'has a valid factory' do
    should be_valid
  end

  context 'when authenticating' do
    let(:user) { create(:user) }
    subject { build(:session, user: nil, email: user.email, password: user.password) }

    it 'sets a user from credentials' do
      expect { subject.validate }.to change { subject.user }.from(nil).to(user)
    end

    it 'is invalid if the credentials are incorrect' do
      subject.password = Faker::Internet.password

      expect { subject.validate }.not_to change { subject.user }
    end
  end
end
