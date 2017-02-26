# frozen_string_literal: true
class SessionPolicy < ApplicationPolicy
  alias session record

  def create?
    guest?
  end

  def destroy?
    session.user == current_user
  end

  def permitted_attributes
    [:email, :password]
  end

  class Scope < Scope
    def resolve
      scope.where(user: current_user)
    end
  end
end
