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

class Session < ApplicationRecord
  attr_accessor :email, :password

  belongs_to :user

  before_validation :set_user_from_credentials, on: :create, if: -> { user.nil? }
  before_validation :set_expires_at, on: :create, if: -> { expires_at.nil? }

  scope :active, lambda {
    where(active: true).where('sessions.expires_at > ?', Time.current)
  }

private

  def set_user_from_credentials
    self.user = User.find_by(email: email)&.authenticate(password) || nil
    errors.add(:base, 'email or password is incorrect') if user.nil?
  end

  def set_expires_at
    self.expires_at = 3.months.from_now
  end
end
