# frozen_string_literal: true
class MessageSerializer < ApplicationSerializer
  attribute :id
  attribute :author_id

  attribute :body
  attribute :created_at
  attribute :updated_at

  belongs_to :author
end
