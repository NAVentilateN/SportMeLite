class Coach::LessonPolicy < ApplicationPolicy
  def resolve
    if user.coach_profile
      scope.where(coach_id: user.id)
    end
  end

  def index?
    user.coach_profile.present?
  end

  def upcoming?
    user.coach_profile.present?
  end

  def history?
    user.coach_profile.present?
  end

  def sync_to_google?
    show?
  end

  def unsync_from_google?
    show?
  end

  def show?
    record.coach == user
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
    record.coach == user && record.status == false # Only when lesson is available and lesson coach can update it
  end

  def destroy?
    record.coach == user # Only lesson coach can destroy it
  end
end
