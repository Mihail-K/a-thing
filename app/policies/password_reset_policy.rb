# frozen_string_literal: true
class PasswordResetPolicy < ApplicationPolicy
  alias password_reset record

  def create?
    guest?
  end

  def update?
    true
  end

  def permitted_attributes_for_create
    :email
  end

  def permitted_attributes_for_update
    [:status, :password, :password_confirmation]
  end

  class Scope < Scope
    def resolve
      scope.pending
    end
  end
end
