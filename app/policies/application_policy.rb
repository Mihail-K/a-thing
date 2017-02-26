# frozen_string_literal: true
class ApplicationPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record       = record
  end

  def index?
    false
  end

  def show?
    scope.exists?(id: record)
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(current_user, record.class)
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope        = scope
    end

    def resolve
      scope
    end
  end
end
