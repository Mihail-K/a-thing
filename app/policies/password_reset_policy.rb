# frozen_string_literal: true
class PasswordResetPolicy < ApplicationPolicy
  alias password_reset record

  def create?
    guest?
  end

  def update?
    true
  end

  class Scope < Scope
    def resolve
      scope.pending
    end
  end
end
