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

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    display_name { Faker::Internet.user_name }

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
