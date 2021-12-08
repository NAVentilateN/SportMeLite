class CoachProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def show?
    true
  end

  def destroy?
    record.user == user
  end
end
