class Coach::CoachProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    update? # Only user can update their own profile
  end

  def update?
    return @record.user == @user # Only user can update their own profile
  end

  def show?
    return true
  end

  def destroy?
    return @record.user == @user # Only user can delete their own profile
  end
end
