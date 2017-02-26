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

FactoryGirl.define do
  factory :password_reset do
    association :user, strategy: :build

    email { user&.email || Faker::Internet.email }

    trait :completed do
      status 'completed'

      password { Faker::Internet.password }
      password_confirmation { password }
    end
  end
end
