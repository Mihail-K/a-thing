# frozen_string_literal: true
class UserPolicy < ApplicationPolicy
  alias user record

  def index?
    true
  end

  def show?
    true
  end

  def create?
    guest?
  end

  def update?
    user == current_user
  end

  def destroy?
    user == current_user
  end

  def permitted_attributes
    [:email, :display_name, :first_name, :last_name, :password, :password_confirmation]
  end
end
