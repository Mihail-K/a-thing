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

FactoryGirl.define do
  factory :session do
    association :user, strategy: :build

    email { user&.email }
    password { user&.password }
  end
end
