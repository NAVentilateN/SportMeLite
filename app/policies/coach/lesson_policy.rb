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

  def show?
    post = authorize Lesson.find(params[:id])
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
