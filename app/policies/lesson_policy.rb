class LessonPolicy < ApplicationPolicy
  class Scope < Scope

    def policy_scope(scope)
      super([:coach, scope])
    end

    def authorize(record, query = nil)
      super([:coach, record], query)
    end

    def resolve
      if user.coach_profile
        scope.where(coach_id: user.id)
      end
    end

    def show
      true
    end

    def new?
      create?
    end

    def create?
      true  # Anyone can create a lesson
    end

    def edit?
      update?
    end

    def update?
      record.coach == user # Only lesson coach can update it
    end

    def destroy?
      record.coach == user # Only lesson coach can destroy it
    end
  end
end
