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

class User < ApplicationRecord
  has_secure_password

  validates :email, :display_name, presence: true
  validates :email, uniqueness: true, if: -> { new_record? || email_changed? }
  validates :display_name, uniqueness: true, if: -> { new_record? || display_name_changed? }
end
