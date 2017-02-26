# frozen_string_literal: true
class PasswordResetSerializer < ApplicationSerializer
  attribute :id
  attribute :user_id
  attribute :status

  attribute :created_at
  attribute :updated_at
end
