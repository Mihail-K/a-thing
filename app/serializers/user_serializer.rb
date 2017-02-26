# frozen_string_literal: true
class UserSerializer < ApplicationSerializer
  attribute :id
  attribute :display_name

  with_options if: :current_user? do
    attribute :email
    attribute :first_name
    attribute :last_name
  end

  attribute :created_at
  attribute :updated_at

  def current_user?
    object == current_user
  end
end
