# frozen_string_literal: true
class SessionSerializer < ApplicationSerializer
  attribute :id
  attribute :user_id

  attribute :active
  attribute :expires_at

  attribute :created_at
  attribute :updated_at

  belongs_to :user
end
