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

class PasswordReset < ApplicationRecord
  attr_accessor :password, :password_confirmation

  belongs_to :user, optional: true

  enum status: {
    pending:   'pending',
    completed: 'completed',
    expired:   'expired'
  }

  validates :email, :status, presence: true
  validates :user, presence: true, if: :completed?

  before_create :set_user_from_email, if: -> { user.nil? }

  with_options if: -> { user.present? } do
    before_create :expire_other_password_resets
    after_commit :send_password_reset_email, on: :create
  end

  with_options if: -> { status_changed?(to: 'completed') } do
    validates :password, presence: true, confirmation: true
    after_save :update_user_password
  end

private

  def set_user_from_email
    self.user = User.find_by(email: email)
  end

  def expire_other_password_resets
    PasswordReset.pending.where(user: user).update_all(status: 'expired')
  end

  def update_user_password
    user.update!(password: password, password_confirmation: password_confirmation)
  end

  def send_password_reset_email
    # TODO : PasswordResetMailer.password_reset(self).deliver_later
  end
end
